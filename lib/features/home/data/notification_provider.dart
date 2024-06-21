// ignore_for_file: use_build_context_synchronously, await_only_futures, prefer_final_fields

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/loaded_widget.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/features/home/models/notification_model.dart';
import 'package:pick_a_service/route/custom_navigator.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notificationList = [];
  bool _isLoading = false;
  bool _isAcceptDeclineLoading = false;
  bool _isNotification = false;

  List<NotificationModel> get notification => _notificationList;
  bool get isLoading => _isLoading;
  bool get isNotification => _isNotification;

  bool get isAcceptDeclineLoading => _isAcceptDeclineLoading;

  Future<void> getNotificationData(BuildContext context) async {
    while (true) {
      if (_notificationList == []) {
        _isLoading = true;

        notifyListeners();
      }
      await Future.delayed(Duration(seconds: 4));

      print("Fetching Notification");
      int techId = SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

      try {
        var headers = {'Content-Type': 'application/json' , 'token' : jwt_token};
        Map<String, dynamic> body = {"technicianId": techId};
        http.Response response = await http.post(Uri.parse(GETNOTIFICATION),
            headers: headers, body: jsonEncode(body));

        var data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          List<NotificationModel> list = [];
          for (var i in data["result"]) {
            NotificationModel model = NotificationModel.fromJson(i);
            list.add(model);
          }

          int a = list.length;
          if (a > _notificationList.length) {
            _isNotification = true;
            notifyListeners();
          }

          _notificationList = list;
          print("notificationList");
          _isLoading = false;
          notifyListeners();
        } else {
          _isLoading = false;
          notifyListeners();
          _notificationList = [];
          // OverlayManager.showToast(
          // type: ToastType.Error, msg: "Something Went Wrong !");
          // return [];
        }
      } catch (e) {
        _isLoading = false;
        notifyListeners();
        _notificationList = [];
        // OverlayManager.showToast(
        // type: ToastType.Error, msg: "Something Went Wrong !");
        throw e;
      }
    }
  }




  Future<void> getNotificationDataWithoutTimer(BuildContext context) async {
 
      if (_notificationList == []) {
        _isLoading = true;

        notifyListeners();
      }

      print("Fetching Notification");
      int techId = SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

      try {
        var headers = {'Content-Type': 'application/json' , 'token' : jwt_token};
        Map<String, dynamic> body = {"technicianId": techId};
        http.Response response = await http.post(Uri.parse(GETNOTIFICATION),
            headers: headers, body: jsonEncode(body));

        var data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          List<NotificationModel> list = [];
          for (var i in data["result"]) {
            NotificationModel model = NotificationModel.fromJson(i);
            list.add(model);
          }

          int a = list.length;
          if (a > _notificationList.length) {
            _isNotification = true;
            notifyListeners();
          }

          _notificationList = list;
          print("notificationList");
          _isLoading = false;
          notifyListeners();
        } else {
          _isLoading = false;
          notifyListeners();
          _notificationList = [];
          // OverlayManager.showToast(
          // type: ToastType.Error, msg: "Something Went Wrong !");
          // return [];
        }
      } catch (e) {
        _isLoading = false;
        notifyListeners();
        _notificationList = [];
        // OverlayManager.showToast(
        // type: ToastType.Error, msg: "Something Went Wrong !");
        throw e;
      
    }
  }

  void notificationBtnCicked() {
    _isNotification = false;
    notifyListeners();
  }

  // void setNotificationList() {
  //   _isLoading = true;
  //   notifyListeners();
  // }

//Accept ORDER
  Future<void> acceptOrder(int ticketId, String status , BuildContext context ) async {
    int techId = await SharedPreferencesManager.getInt("user_id");
    String jwt_token = await SharedPreferencesManager.getString("jwt_token");

    _isLoading = true;

    notifyListeners();
    print(ticketId);
    try {
      var headers = {'Content-Type': 'application/json' , 'token'  :jwt_token};
      Map<String, dynamic> body = {
        "technicianId": techId,
        "ticketId": ticketId,
        "status": status
      };
      http.Response response = await http.post(Uri.parse(ACCEPTORDER),
          headers: headers, body: jsonEncode(body));

      print(response);
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        print("Accept Orders");
        // for(var i in data["result"]){
        //   NotificationModel _model = NotificationModel.fromJson(i);
        //   _notificationList.add(_model);
        // }
        OverlayManager.showToast(type: ToastType.Success, msg: data["message"]);
        _isLoading = false;

        if(_notificationList.isEmpty && (status == "Accepted")){
          CustomNavigator.pop(context);
        }
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        // OverlayManager.showToast(
        //     type: ToastType.Error, msg: "Something went wrong !");

        throw data["message"];
      }
    } catch (e) {
      // OverlayManager.showToast(
      //     type: ToastType.Error, msg: "Something went wrong !");
      throw e;
    }
  }

//DECLINE ORDER
  Future<void> declineOrder(int ticketId , BuildContext context) async {
    int techId = await SharedPreferencesManager.getInt("user_id");
    _isLoading = true;
    _isAcceptDeclineLoading = true;
    notifyListeners();
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'Content-Type': 'application/json' , 'token' : jwt_token};
      Map<String, dynamic> body = {
        "technicianId": techId,
        "ticketId": ticketId
      };
      http.Response response = await http.post(Uri.parse(DECLINEORDER),
          headers: headers, body: jsonEncode(body));

      print(response);
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        OverlayManager.showToast(type: ToastType.Success, msg: data["message"]);
        _isLoading = false;
        _isAcceptDeclineLoading = false;
if(_notificationList.isEmpty){
          CustomNavigator.pop(context);
        }
        notifyListeners();
      } else {
        _isLoading = false;
        _isAcceptDeclineLoading = false;

        notifyListeners();
        // OverlayManager.showToast(
        //     type: ToastType.Error, msg: "Something went wrong !");
        throw data["message"];
      }
    } catch (e) {
      // OverlayManager.showToast(
      //     type: ToastType.Error, msg: "Something went wrong !");
      throw e;
    }
  }

  bool _isStarted = false;
  bool get isStarted => _isStarted;

  bool _isReached = false;
  bool get isReached => _isReached;

  void Start(bool a) {
    _isStarted = a;
    notifyListeners();
  }

  void Reached(bool a) {
    _isReached = a;
    notifyListeners();
  }

  bool _isChecklist = false;
  bool get isChecklist => _isChecklist;

  void Checklist(bool a) {
    _isChecklist = a;
    notifyListeners();
  }

  // List<String> status = [];

  //===============Completed Task ====================
}
