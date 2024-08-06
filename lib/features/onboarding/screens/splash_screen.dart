// import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pick_a_service/core/constants/app_data.dart';
import 'package:pick_a_service/core/managers/app_manager.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/onboarding/data/provider/login_provider.dart';
import 'package:pick_a_service/features/onboarding/screens/login_screen.dart';
import 'package:pick_a_service/language_provider.dart';
import 'package:pick_a_service/main.dart';
import 'package:pick_a_service/navbar.dart';
import 'package:pick_a_service/notification_service.dart';
import 'package:provider/provider.dart';

import '../../../../route/app_pages.dart';
import '../../../../route/custom_navigator.dart';

import '../../../../core/app_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AppData.lang = SharedPreferencesManager.getString("lang");
    init();
  }

  NotificationService service = NotificationService();
  Future<void> init() async {
    if (lang == "ar") {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        Provider.of<LanguageChangeProvider>(context, listen: false)
            .changeLanguage(Locale('ar'));
      });
    }
   
    
    if (SharedPreferencesManager.getBool("isLogin")) {
    String email = await SharedPreferencesManager.getString("email_id");
 final p = Provider.of<LoginProvider>(context, listen: false);
    await p.getTechnicianActivation(email);
    print(p.isActive);
      if (p.isActive == 1) {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return NavBarScreen();
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          );
          // CustomNavigator.pushReplace(context, AppPages.navbar);
        });
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Account Deactivated'),
              content: Text(
                  'Your account has been deactivated by Admin. Contact admin to know more.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return LoginScreen();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
        // CustomNavigator.pushReplace(context, AppPages.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.height70,
            Image.asset(
              AppIcons.app_logo,
              color: AppColors.white,
              height: 43.h,
              width: 56.w,
            ),
            CustomSpacers.height80,
            CustomSpacers.height48,
            Center(
              child: SvgPicture.asset(
                AppImages.splash_image,
                height: 404.h,
                width: 303.w,
              ),
            ),
            CustomSpacers.height56,
          ],
        ),
      ),
    );
  }

  // void _navigateToNotification(BuildContext context , Widget w) {
  //   Navigator.of(context)
  //       .push(
  //     PageRouteBuilder(
  //       transitionDuration: const Duration(milliseconds: 500),
  //       pageBuilder: (context, animation, secondaryAnimation) {
  //         return FadeTransition(
  //           opacity: animation,
  //           child:w
  //               , // Replace with your notification screen
  //         );
  //       },
  //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //         const begin = Offset(1.0, 0.0);
  //         const end = Offset.zero;
  //         const curve = Curves.ease;
  //         var tween =
  //             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //         var offsetAnimation = animation.drive(tween);
  //         return SlideTransition(
  //           position: offsetAnimation,
  //           child: child,
  //         );
  //       },
  //     ),
  //   )
  //       ;
  // }
}
