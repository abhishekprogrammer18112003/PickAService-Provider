// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/features/home/screens/notification_screen.dart';
import 'package:pick_a_service/location_service.dart';
import 'package:pick_a_service/ticket_details_model.dart';

class NotificationService {
  LocationService locationService = LocationService();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<bool> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permission");
      await locationService.startLocationService(true);
      return true;
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User Granted provisional Permission");
      return true;
    } else {
      print("User denied Permission");
      return false;
    }
  }

  Future<String> getToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  Future<String?> getDeviceId(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    }
  }

  void isRefreshToken() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/launcher_icon");
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      HandleReceive(context, message);
    });
  }

  Future<void> firebaseInit(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        showNotification(message);
        HandleReceive(context, message); // Handle navigation here
      } else {
        showNotification(message);
        HandleReceive(context, message); // Handle navigation here
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(),
        'High Importance Notification',
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'Your Channel Description',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    // Extracting payload data
    Map<String, dynamic> payloadData = message.data;

    Future.delayed(Duration.zero, () {
      print("=============payload data===============");
      print(payloadData);
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
          payload: payloadData.toString()); // Adding payload data
    });
  }

  void HandleReceive(BuildContext context, RemoteMessage? message) {
    print("===============handle Receive ================");
    print(message!.data);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotificationScreen()));
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // when app terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      HandleReceive(context, initialMessage); // Handle navigation here
    }

    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      HandleReceive(context, event); // Handle navigation here
    });
  }
}

class NotificationServiceProvider with ChangeNotifier {
  List<TicketDetailsModel> _TicketDetails = [];
  bool _isNotificationLoading = false;

  List<TicketDetailsModel> get TicketDetails =>
      _TicketDetails;

  bool get isNotificationLoading => _isNotificationLoading;

  Future<void> getTicketData(BuildContext context, int ticketId) async {
    _isNotificationLoading = true;

    notifyListeners();

    print("Upcoming Data");
    int techId = SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {"ticketId": ticketId};
      http.Response response = await http.post(Uri.parse(GETTICKETDETAILS),
          headers: headers, body: jsonEncode(body));

      var data = jsonDecode(response.body);
      print("data");
      if (response.statusCode == 200) {
        List<TicketDetailsModel> list = [];

        for (var i in data["result"]) {
          TicketDetailsModel _model =
              TicketDetailsModel.fromJson(i);
          list.add(_model);
        }

        _TicketDetails = list;
        _isNotificationLoading = false;
        notifyListeners();

        // return _notificationList;
      } else {
        print("else");
        _TicketDetails = [];
        _isNotificationLoading = false;
        notifyListeners();
        // OverlayManager.showToast(
        // type: ToastType.Error, msg: "Something Went Wrong !");
        // return [];
      }
    } catch (e) {
      print("catch");
      _TicketDetails = [];
      _isNotificationLoading = false;
      notifyListeners();
      // OverlayManager.showToast(
      // type: ToastType.Error, msg: "Something Went Wrong !");
      throw e;
    }
  }
}
