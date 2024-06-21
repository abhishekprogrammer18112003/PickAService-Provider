// ignore_for_file: non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pick_a_service/core/constants/app_themes.dart';
import 'package:pick_a_service/core/constants/value_constants.dart';
import 'package:pick_a_service/core/loaded_widget.dart';
import 'package:pick_a_service/core/managers/app_manager.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/data/home_provider.dart';
import 'package:pick_a_service/features/home/data/notification_provider.dart';
import 'package:pick_a_service/features/onboarding/data/provider/login_provider.dart';
import 'package:pick_a_service/features/onboarding/screens/splash_screen.dart';
import 'package:pick_a_service/features/profile/data/profile_provider.dart';
import 'package:pick_a_service/features/service%20history/data/schedule_history_provider.dart';
import 'package:pick_a_service/features/ticket_details_provider.dart';
import 'package:pick_a_service/language_provider.dart';
import 'package:pick_a_service/notification_service.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

String lang = "";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppManager.initialize();
  FirebaseMessaging.onBackgroundMessage(_FirebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _FirebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
   

    getDeviceID();
    notificationService.setupInteractMessage(context);
    notificationService.firebaseInit(context);
    notificationService.getToken().then((value) {
      print('Device Token');
      print(value);

      SharedPreferencesManager.setString("deviceToken", value);
    });
  }

  Future<void> getDeviceID() async {
    String? id = await notificationService.getDeviceId(context);
    SharedPreferencesManager.setString("deviceID", id);
    print("Device ID");
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScheduleHistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TicketDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageChangeProvider(),
        ),
      ],
      child: ScreenUtilInit(
          designSize:
              const Size(VALUE_FIGMA_DESIGN_WIDTH, VALUE_FIGMA_DESIGN_HEIGHT),
          builder: () => Consumer<LanguageChangeProvider>(
                builder: (context, value, child) => MaterialApp(
                  locale: value.appLocale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [Locale('en'), Locale('ar')],
                  debugShowCheckedModeBanner: false,
                  title: 'pick a service',
                  initialRoute: '/',
                  onGenerateRoute: CustomNavigator.controller,
                  themeMode: ThemeMode.light,
                  builder: OverlayManager.transitionBuilder(),
                  theme: AppThemes.light,
                  home: const SplashScreen(),
                ),
              )),
    );
  }
}
