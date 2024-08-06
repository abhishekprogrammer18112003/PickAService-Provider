import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/loaded_widget.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/features/profile/models/profile_data_model.dart';
import 'package:pick_a_service/route/custom_navigator.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isPersonalLoading = false;
  bool get isPersonalLoading => _isPersonalLoading;
  Map<String, dynamic> _profileDataModel = {};

  String _name = "";
  String get name => _name;
  Map<String, dynamic> get profileDataModel => _profileDataModel;
  Future<void> getPersonalData(BuildContext context) async {
    _isPersonalLoading = true;

    notifyListeners();

    print("Fetching Personal Data");
    int techId = SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {"userId": techId, "userType": "technician"};
      http.Response response = await http.post(Uri.parse(PERSONALDATA),
          headers: headers, body: jsonEncode(body));

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("hello");

        _profileDataModel = data["result"];
        _isPersonalLoading = false;
        notifyListeners();
      } else {
        // _profileDataModel = ProfileDataModel.fromJson({});

        _isPersonalLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _isPersonalLoading = false;
      notifyListeners();

      throw e;
    }
  }

  void getName(String n) {
    _name = n;
    notifyListeners();
  }

  //======================== EDIT PERSONAL DATA ======================
  bool _isEditLoading = false;
  bool get isEditLoading => _isEditLoading;
  Future<void> editPersonalDataWithoutPhone(
      BuildContext context, String name, String image) async {
    _isEditLoading = true;

    notifyListeners();
    int techId = SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'token': jwt_token};
      var request = http.MultipartRequest('POST', Uri.parse(EDITPROFILE));
      request.fields.addAll({
        'userId': techId.toString(),
        'userType': 'technician',
        'FullName': name,
        'isPhoneChanged': '0',
        'isPwdChanged': '0'
      });
      image != ""
          ? request.files
              .add(await http.MultipartFile.fromPath('profilePic', image))
          : null;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print("success");
        print(await response.stream.bytesToString());
        getName(name);
        _isEditLoading = false;

        notifyListeners();
      } else {
        print("else");
        _isEditLoading = false;

        notifyListeners();
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      print("catch");
      // _profileDataModel = ProfileDataModel.fromJson({});

      _isEditLoading = false;
      notifyListeners();

      // OverlayManager.showToast(type: ToastType.Error, msg: e.toString());
      throw e;
    }
  }

  //===========change password ==========================

  Future<void> changePassword(BuildContext context, String password) async {
    _isEditLoading = true;
    notifyListeners();
    int techId = SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    var headers = {'token': jwt_token};
    var request = http.MultipartRequest('POST', Uri.parse(CHANGEPASSWORD));
    request.fields.addAll({
      'userId': techId.toString(),
      'userType': 'technician',
      'isPwdChanged': '1',
      'password': password
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      _isEditLoading = false;
      notifyListeners();
      Navigator.pop(context);
    } else {
      _isEditLoading = false;
      notifyListeners();
      print(response.reasonPhrase);
    }
  }

  Future<void> editPersonalDataWithPhone(
      BuildContext context, String mobile, String name) async {
    _isEditLoading = true;

    notifyListeners();
    int techId = SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'token': jwt_token};
      var request = http.MultipartRequest('POST', Uri.parse(EDITPROFILE));
      request.fields.addAll({
        'userId': techId.toString(),
        'userType': 'technician',
        'isPhoneChanged': '1',
        'PhoneNo': mobile.toString(),
        'isPwdChanged': '0',
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print("success");
        print(await response.stream.bytesToString());
        _isEditLoading = false;

        notifyListeners();
      } else {
        print("else");
        _isEditLoading = false;

        notifyListeners();
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      print("catch");
      // _profileDataModel = ProfileDataModel.fromJson({});

      _isEditLoading = false;
      notifyListeners();

      // OverlayManager.showToast(type: ToastType.Error, msg: e.toString());
      throw e;
    }
  }

  // ============================OTP ==================================
  bool _isOtp = false;
  bool get isOtp => _isOtp;

  Future<void> UpdataPhoneData(
      BuildContext context, String otp, String phoneNo) async {
    _isEditLoading = true;

    notifyListeners();
    print(otp);
    print(phoneNo);
    int techId = SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");
    try {
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {
        "otp": int.parse(otp),
        "PhoneNo": int.parse(phoneNo),
        "userId": techId,
        "userType": "technician"
      };
      http.Response response = await http.post(Uri.parse(GETOTP),
          headers: headers, body: jsonEncode(body));
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        OverlayManager.showToast(
                                  type: ToastType.Success,
                                  msg: "Number changed successfully!");
        _isEditLoading = false;
        notifyListeners();
        CustomNavigator.pop(context);
        CustomNavigator.pop(context);
      } else {
        OverlayManager.showToast(
                                  type: ToastType.Alert,
                                  msg: "Please enter correct OTP!");
        print("error");
        _isEditLoading = false;
        notifyListeners();

        // OverlayManager.showToast(type: ToastType.Error, msg: data["message"]);
        // return [];
      }
    } catch (e) {
      _isEditLoading = false;
      notifyListeners();

      // OverlayManager.showToast(type: ToastType.Error, msg: e.toString());
      throw e;
    }
  }
}
