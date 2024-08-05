import 'dart:async';
import 'dart:ui';

import 'package:background_location/background_location.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pick_a_service/core/managers/app_manager.dart';
import 'package:pick_a_service/location_service.dart';

Future<void> initializeService15secs() async {
  final service = FlutterBackgroundService();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    "script academy",
    "Location Service",
    importance: Importance.low,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
        notificationChannelId: "script academy",
        initialNotificationTitle: "Location Service",
        initialNotificationContent: "Live tracking enabled",
        foregroundServiceNotificationId: 888,
      ));
  service.startService();
}

@pragma('vm-entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  // await BackgroundLocation.setAndroidNotification(
  //   title: "Location tracking is running in the background!",
  //   message: "You can turn it off from settings menu inside the app",
  //   icon: '@mipmap/ic_logo',
  // );
  // BackgroundLocation.startLocationService(
  //   distanceFilter: 20,
  // );

  // BackgroundLocation.getLocationUpdates((location) {
  //   clocation = location;
  // });

  LocationServiceProvider locationServiceProvider = LocationServiceProvider();

  Timer.periodic(Duration(seconds: 15), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
                forceAndroidLocationManager: true)
            .then((Position position) {
          locationServiceProvider.sendLocationToBackend(position);
        }).catchError((e) {
          Fluttertoast.showToast(msg: e.toString());
        });

        // await location.startLocationService(true);

        flutterLocalNotificationsPlugin.show(
          888,
          "Pick A Service",
          "Location sending to backend",
          NotificationDetails(
              android: AndroidNotificationDetails(
            "script academy",
            "Location Service",
            icon: 'ic_bg_service_small',
            ongoing: true,
          )),
        );
      }
    }
  });
}


Future<void> stopBackgroundService() async{
  final service = FlutterBackgroundService();
   service.invoke("stopService");
}
