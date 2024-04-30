import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pick_a_service/core/constants/url_constants.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/ticket_details_model.dart';

class TicketDetailsProvider with ChangeNotifier {
  List<TicketDetailsModel> _TicketDetails = [];
  bool _isNotificationLoading = false;

  List<TicketDetailsModel> get TicketDetails => _TicketDetails;

  bool get isNotificationLoading => _isNotificationLoading;

  Future<void> getTicketData(BuildContext context, int ticketId) async {
    _isNotificationLoading = true;

    notifyListeners();

    print("get ticket details Data");
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
          TicketDetailsModel _model = TicketDetailsModel.fromJson(i);
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
