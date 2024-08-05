// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/loaded_widget.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/features/onboarding/models/login_model.dart';
import 'package:pick_a_service/navbar.dart';

class LoginProvider extends ChangeNotifier {
  LoginModel? _user;
  bool _isLoading = false;

  LoginModel? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> getLoginData(
      String email, String password, BuildContext context, String lang) async {
    _isLoading = true;
    notifyListeners();
    String deviceID = await SharedPreferencesManager.getString("deviceID");
    String deviceToken =
        await SharedPreferencesManager.getString("deviceToken");
    try {
      var headers = {'Content-Type': 'application/json', 'lang': lang};
      Map<String, dynamic> body = {
        "email": email,
        "password": password,
        "device_id": deviceID,
        "device_token": deviceToken,
        "source": "tech_Android"
      };
      http.Response response = await http.post(Uri.parse(LOGIN),
          headers: headers, body: jsonEncode(body));

      // print(response);
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _user = LoginModel.fromJson(data["result"]);
        print(_user);
        _isLoading = false;
        notifyListeners();
        SharedPreferencesManager.setInt("user_id", _user!.userId);
        SharedPreferencesManager.setString("email_id", _user!.email);
        SharedPreferencesManager.setString("jwt_token", _user!.token);
        SharedPreferencesManager.setBool("isLogin", true);

        // _navigateToNotification(context, NavBarScreen());
        // CustomNavigator.pushReplace(context, AppPages.navbar);

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) => NavBarScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0.0, -1.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
      } else {
        _isLoading = false;
        notifyListeners();
        OverlayManager.showToast(type: ToastType.Error, msg: data["message"]);
        throw data["message"];
      }
    } catch (e) {
      // OverlayManager.showToast(type: ToastType.Error, msg: e.toString());s
      throw e;
    }
  }

  void _navigateToNotification(BuildContext context, Widget w) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: w, // Replace with your notification screen
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }





  int _isActive = 1;
  int get isActive => _isActive;

  Future<void> getTechnicianActivation(
      String email) async {

   
    try {
      var headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {
        "email": email,
       
      };
      http.Response response = await http.post(Uri.parse(TECHNICIANACTIVATION),
          headers: headers, body: jsonEncode(body));

      // print(response);
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _isActive = data['isActive'];
        notifyListeners();
        
      } else {
       
        // OverlayManager.showToast(type: ToastType.Error, msg: data["message"]);
        throw data["message"];
      }
    } catch (e) {
      // OverlayManager.showToast(type: ToastType.Error, msg: e.toString());s
      throw e;
    }
  }
}
