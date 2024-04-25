// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/features/home/models/notification_model.dart';
import 'package:pick_a_service/location_service.dart';
import 'package:pick_a_service/ui/molecules/search_places.dart';

class BackgroundService {
  void initializeService() async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
    service.startService();
  }
  
  void onStart(ServiceInstance service) async {
    print("hello");
    LocationService service = LocationService();
    service.startLocationService(true);
  }

  
  Future<bool> onIosBackground(ServiceInstance service) async {
    // iOS-specific background fetch implementation
    return true;
  }
}
