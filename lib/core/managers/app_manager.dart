// ignore_for_file: use_build_context_synchronously, unused_import

import 'dart:async';

import 'package:background_location/background_location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pick_a_service/core/constants/app_data.dart';
import 'package:pick_a_service/firebase_options.dart';
import 'package:pick_a_service/flutter_background_service_10min.dart';
import 'package:pick_a_service/language_provider.dart';
import 'package:pick_a_service/location_service.dart';
import 'package:pick_a_service/main.dart';
import 'package:pick_a_service/notification_service.dart';
import 'package:provider/provider.dart';
import 'shared_preference_manager.dart';

NotificationService notificationService = NotificationService();
LocationService locationService = LocationService();

class AppManager {
  static Future<void> initialize() async {
    // Initialize Firebase and other services
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // await initializeService();
await locationService.startLocationService(true);
    await SharedPreferencesManager.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    lang = SharedPreferencesManager.getString("lang");
    lang = lang.isEmpty ? "en" : lang;
    print(lang);
    // Request permissions and start the location service
    // await requestPermissionsAndStartService();
  }
}

Future<void> requestPermissionsAndStartService() async {
  // var status = await Permission.locationAlways.request();
  // if (status.isGranted) {/
    startLocationService();
  // } else {
    // print("Location permission denied");
  // }S
}

LocationServiceProvider locationServiceProvider = LocationServiceProvider();

void startLocationService() {
  BackgroundLocation.startLocationService();
  
  BackgroundLocation.setAndroidNotification(
    title: "Location Service",
    message: "Fetching location in the background",
    icon: "@mipmap/ic_launcher",
  );

  Timer.periodic(Duration(seconds: 10), (timer) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
      );
      print("=========Location============");
      print(position.latitude);
      print(position.longitude);
      await locationServiceProvider.sendLocationToBackend(position);
    } catch (e) {
      print("Error fetching location: $e");
    }
  });
}
