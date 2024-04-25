// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import '../app_imports.dart';

// class NotificationHelpers {
//   // Create an Android notification channel object with the specified details.
//   static const androidNotificationChannel = AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.high,
//     playSound: true,
//   );

//   // Create a FlutterLocalNotificationsPlugin instance.
//   static final flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Create a NotificationDetails object with the Android notification details.
//   static final _notificationDetails = NotificationDetails(
//     android: AndroidNotificationDetails(
//       androidNotificationChannel.id,
//       androidNotificationChannel.name,
//       channelDescription: androidNotificationChannel.description,
//       color: AppColors.primary,
//       playSound: true,
//       icon: '@mipmap/ic_launcher',
//     ),
//   );

//   // Handles incoming messages when the app is in the background.
//   static Future<void> _onBackgroundMessageHandler(
//       RemoteMessage message) async {}

//   // Handles incoming messages when the app is in the foreground.
//   static Future<void> _onMessageHandler(RemoteMessage message) async {
//     final remoteNotification = message.notification;
//     final androidNotification = message.notification?.android;
//     if (remoteNotification == null || androidNotification == null) {
//       return;
//     }
//     // Show the notification using the FlutterLocalNotificationsPlugin instance.
//     await flutterLocalNotificationsPlugin.show(
//       remoteNotification.hashCode,
//       remoteNotification.title,
//       remoteNotification.body,
//       _notificationDetails,
//     );
//   }

//   // Handles incoming messages when the app is opened from a terminated state.
//   static Future<void> _onMessageOpenedAppHandler(RemoteMessage message) async {
//     final remoteNotification = message.notification;
//     final androidNotification = message.notification?.android;
//     if (remoteNotification == null || androidNotification == null) {
//       return;
//     }
//     // Navigate to a specific page in the app.
//     // TODO: Implement page navigation functionality.
//   }

//   // Initializes the necessary components for handling notifications.
//   static Future<void> initialize() async {
//     // Create the Android notification channel using the
//     // AndroidFlutterLocalNotificationsPlugin implementation.
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(androidNotificationChannel);

//     // Set the foreground notification presentation options for FirebaseMessaging.
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     // Set up the message handler for incoming messages when the app is in the background.
//     FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);

//     // Set up the message handler for incoming messages when the app is in the foreground.
//     FirebaseMessaging.onMessage.listen(_onMessageHandler);

//     // Set up the message handler when the user clicks on a FCM
//     FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedAppHandler);

//     // Get the initial message if the app was opened from a terminated state.
//     // final message = await FirebaseMessaging.instance.getInitialMessage();
//   }
// }
