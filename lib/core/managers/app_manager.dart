// ignore_for_file: use_build_context_synchronously


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:pick_a_service/core/constants/app_data.dart';
import 'package:pick_a_service/firebase_options.dart';
import 'package:pick_a_service/flutter_background_service.dart';
import 'package:pick_a_service/location_service.dart';
import 'package:pick_a_service/main.dart';
import 'package:pick_a_service/notification_service.dart';
import 'shared_preference_manager.dart';

NotificationService notificationService = NotificationService();
LocationService locationService = LocationService();
BackgroundService service = BackgroundService();

class AppManager {

  
  static Future<void> initialize() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SharedPreferencesManager.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    lang = SharedPreferencesManager.getString("lang");
    lang == "" ? lang = "en"  : lang = SharedPreferencesManager.getString("lang");  
    print(lang);
   

    // service.initializeService();
    
    
    
  }
}
