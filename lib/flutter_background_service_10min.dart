import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pick_a_service/core/managers/app_manager.dart';
import 'package:pick_a_service/location_service.dart';

Future<void> initializeService() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensure the bindings are initialized

  final service = FlutterBackgroundService();

  if (await service.isRunning()) {
    print("Service is already running.");
    return;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    "script_academy",
    "Foreground Service",
    importance: Importance.low,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      notificationChannelId: "script_academy",
      initialNotificationTitle: "Location Service",
      initialNotificationContent: "Live tracking enabled",
      foregroundServiceNotificationId: 888,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();

    // Create and show the notification immediately to avoid the exception
    final notification = NotificationDetails(
      android: AndroidNotificationDetails(
        "script_academy",
        "Location Service",
        icon: 'ic_bg_service_small',
        importance: Importance.low,
        priority: Priority.defaultPriority,
        ongoing: true,
      ),
    );

    flutterLocalNotificationsPlugin.show(
      888,
      "Pick A Service",
      "Live tracking enabled",
      notification,
    );

    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('stopService').listen((event) {
      service.stopSelf();
    });
  }

  DartPluginRegistrant.ensureInitialized();

  Timer.periodic(Duration(minutes: 10), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        try {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true,
          );

          await locationServiceProvider.sendLocationToBackend(position);

          flutterLocalNotificationsPlugin.show(
            888,
            "Pick A Service",
            "Location sent to backend",
            NotificationDetails(
              android: AndroidNotificationDetails(
                "script_academy",
                "Location Service",
                icon: 'ic_bg_service_small',
                importance: Importance.low,
                priority: Priority.defaultPriority,
                ongoing: true,
              ),
            ),
          );
        } catch (e) {
          // Handle the exception accordingly
          print("Error sending location: $e");
        }
      }
    }
  });
}
