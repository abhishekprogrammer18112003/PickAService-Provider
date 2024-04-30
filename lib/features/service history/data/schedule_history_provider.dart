import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/loaded_widget.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/features/service%20history/models/completed_task.dart';
import 'package:pick_a_service/features/service%20history/models/schedule_history_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pick_a_service/route/custom_navigator.dart';

class ScheduleHistoryProvider with ChangeNotifier {
  List<ScheduleHistoryModel> _upcomingTickets = [];
  bool _isUpcomingLoading = false;

  List<ScheduleHistoryModel> get upcomingTickets => _upcomingTickets;

  bool get isUpcomingLoading => _isUpcomingLoading;

  Future<void> getUpcomingTicketsData(BuildContext context) async {
    _isUpcomingLoading = true;

    notifyListeners();

    print("Upcoming Data");
    int techId = SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");


    try {
      var headers = {'Content-Type': 'application/json' , 'token' : jwt_token};
      Map<String, dynamic> body = {"technicianId": techId};
      http.Response response = await http.post(Uri.parse(GETUPCOMINGTICKETS),
          headers: headers, body: jsonEncode(body));

      var data = jsonDecode(response.body);
      print("data");
      if (response.statusCode == 200) {
        List<ScheduleHistoryModel> list = [];
        for (var i in data["ticket"]) {
          ScheduleHistoryModel model = ScheduleHistoryModel.fromJson(i);
          list.add(model);
        }

        _upcomingTickets = list;
        print(_upcomingTickets);
        _isUpcomingLoading = false;
        notifyListeners();

        // return _notificationList;
      } else {
        print("else");
        _upcomingTickets = [];
        _isUpcomingLoading = false;
        notifyListeners();
        // OverlayManager.showToast(
        // type: ToastType.Error, msg: "Something Went Wrong !");
        // return [];
      }
    } catch (e) {
      print("catch");
      _upcomingTickets = [];
      _isUpcomingLoading = false;
      notifyListeners();
      // OverlayManager.showToast(
      // type: ToastType.Error, msg: "Something Went Wrong !");
      throw e;
    }
  }

  bool _isAcceptDeclineLoading = false;

  bool get isAcceptDeclineLoading => _isAcceptDeclineLoading;

  //Accept ORDER

  Future<void> acceptOrder(
      int ticketId, String status, BuildContext context) async {
    int techId = await SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    _isAcceptDeclineLoading = true;

    notifyListeners();
    print(ticketId);
    try {
      var headers = {'Content-Type': 'application/json' , 'token' : jwt_token};
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
        // for(var i in data["result"]){
        //   NotificationModel _model = NotificationModel.fromJson(i);
        //   _notificationList.add(_model);
        // }
        OverlayManager.showToast(type: ToastType.Success, msg: data["message"]);
        _isAcceptDeclineLoading = false;

        notifyListeners();
        CustomNavigator.pop(context);
      } else {
        _isAcceptDeclineLoading = false;
        notifyListeners();
        OverlayManager.showToast(
            type: ToastType.Error, msg: "Something went wrong !");

        // throw data["message"];
      }
    } catch (e) {
      OverlayManager.showToast(
          type: ToastType.Error, msg: "Something went wrong !");
      throw e;
    }
  }

//DECLINE ORDER
  Future<void> declineOrder(int ticketId, BuildContext context) async {
    int techId = await SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    _isAcceptDeclineLoading = true;

    notifyListeners();
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
        // OverlayManager.showToast(type: ToastType.Success, msg: data["message"]);
        _isAcceptDeclineLoading = false;

        notifyListeners();
        CustomNavigator.pop(context);
      } else {
        _isAcceptDeclineLoading = false;

        notifyListeners();
        // OverlayManager.showToast(
        // type: ToastType.Error, msg: "Something went wrong !");
        throw data["message"];
      }
    } catch (e) {
      // OverlayManager.showToast(
      // type: ToastType.Error, msg: "Something went wrong !");
      throw e;
    }
  }

  // ==================== COMPLETED TASKS ================================

  List<CompletedTasksModel> _completeTaskList = [];
  List<CompletedTasksModel> get completeTaskList => _completeTaskList;
  Future<void> completeTask(String status) async {
    int techId = await SharedPreferencesManager.getInt("user_id");
    _isUpcomingLoading = true;

    notifyListeners();
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'Content-Type': 'application/json' , 'token' : jwt_token};
      Map<String, dynamic> body = {
        "technicianId": techId,
        "workStatus": status,
      };
      http.Response response = await http.post(Uri.parse(COMPLETED),
          headers: headers, body: jsonEncode(body));

      print(response);
      var data = jsonDecode(response.body);
      print(data);
      List<CompletedTasksModel> list = [];
      if (response.statusCode == 200) {
        for (var i in data["result"]) {
          CompletedTasksModel _model = CompletedTasksModel.fromJson(i);
          list.add(_model);
        }
        _completeTaskList = list;
        _isUpcomingLoading = false;

        notifyListeners();
      } else {
        _completeTaskList = [];
        _isUpcomingLoading = false;
        notifyListeners();
        // OverlayManager.showToast(
        // type: ToastType.Error, msg: "Something went wrong !");

        // throw data["message"];
      }
    } catch (e) {
      _completeTaskList = [];

      _isUpcomingLoading = false;
      notifyListeners();
      // OverlayManager.showToast(
      // type: ToastType.Error, msg: "Something went wrong !");
      throw e;
    }
  }





  // =============fiilter completed task ================


  // Future<void> filetrCompleteTask(String status) async {
  //   int techId = await SharedPreferencesManager.getInt("user_id");
  //   _isUpcomingLoading = true;

  //   notifyListeners();
  //   String jwt_token = SharedPreferencesManager.getString("jwt_token");

  //   try {
  //     var headers = {'Content-Type': 'application/json' , 'token' : jwt_token};
  //     Map<String, dynamic> body = {
  //       "technicianId": techId,
  //       "workStatus": status,
  //     };
  //     http.Response response = await http.post(Uri.parse(FILTERCOMPLETEDTASK),
  //         headers: headers, body: jsonEncode(body));

  //     print(response);
  //     var data = jsonDecode(response.body);
  //     print(data);
  //     List<CompletedTasksModel> list = [];
  //     if (response.statusCode == 200) {
  //       for (var i in data["result"]) {
  //         CompletedTasksModel _model = CompletedTasksModel.fromJson(i);
  //         list.add(_model);
  //       }
  //       _completeTaskList = list;
  //       _isUpcomingLoading = false;

  //       notifyListeners();
  //     } else {
  //       _completeTaskList = [];
  //       _isUpcomingLoading = false;
  //       notifyListeners();
  //       // OverlayManager.showToast(
  //       // type: ToastType.Error, msg: "Something went wrong !");

  //       // throw data["message"];
  //     }
  //   } catch (e) {
  //     _completeTaskList = [];

  //     _isUpcomingLoading = false;
  //     notifyListeners();
  //     // OverlayManager.showToast(
  //     // type: ToastType.Error, msg: "Something went wrong !");
  //     throw e;
  //   }
  // }
}
