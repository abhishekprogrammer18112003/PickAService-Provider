import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../constants/app_error_message.dart';
import '../error/failure.dart';
import 'package:intl/intl.dart';

class Utils {
  static EdgeInsets getStatusBarSize(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Brightness getCurrentAppTheme(context) {
    return SchedulerBinding.instance.window.platformBrightness;
  }

  static getAppTextTheme(context) {
    return Theme.of(context).textTheme;
  }

  static void dismissKeypad(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  // static String getAppName() {
  //   return FlavorTypes.appTitle;
  // }

  // static Future<String> getAppVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   return packageInfo.version;
  // }

  // static Future<String> getAppVersionCode() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   return packageInfo.buildNumber;
  // }

  static String getDefaultCountryCode() {
    return "+91";
  }

  static List<String> getMinutes() {
    NumberFormat formatter = NumberFormat("00");
    List<int> mins = [];
    for (int i = 0; i < 60; i++) {
      mins.add(i);
    }
    return mins.map((e) => formatter.format(e)).toList();
  }

  static List<String> getHours() {
    NumberFormat formatter = NumberFormat("00");
    List<int> hours = [];
    for (int i = 1; i <= 12; i++) {
      hours.add(i);
    }
    return hours.map((e) => formatter.format(e)).toList();
  }

  // Print only in debug builds
  static printLogs(dynamic strData) {
    if (kDebugMode) {
      print(strData);
    }
  }

  static String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case InternetFailure:
        return AppErrorMessage.internetFailure;
      case ServerFailure:
        return AppErrorMessage.serverFailure;
      case FirbaseMyFailure:
        return AppErrorMessage.firebaseFailure;
      case ValidationFailure:
        return AppErrorMessage.validationFailure;
      case ApiFailure:
        return mapApiFailureToMessage(failure as ApiFailure);
      default:
        return AppErrorMessage.generalFailure;
    }
  }

  static String mapApiFailureToMessage(ApiFailure failure) {
    switch (failure.message) {
      default:
        return failure.message;
    }
  }

  // static bool isUserLoggedIn() {
  //   var token = UserHelpers.getAuthToken();
  //   if (token.isNotEmpty && token != false) {
  //     return true;
  //   }
  //   return false;
  // }

  // static launchURL(Uri uri,
  //     {LaunchMode launchMode = LaunchMode.platformDefault}) async {
  //   if (!await launchUrl(uri, mode: launchMode)) ;
  //   throw 'Could not launch $uri';
  // }

  // static launchMail(String email, String subject) async {
  //   final Uri emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     path: URL_SUPPORT_EMAIL,
  //     query: _encodeQueryParameters(<String, String>{'subject': subject}),
  //   );
  //   Utils.launchURL(emailLaunchUri);
  // }

  // static launchWhatsapp(String phoneNumber) async {
  //   await FlutterLaunch.launchWhatsapp(phone: phoneNumber, message: "");
  // }

  static String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static void printJson(String input) {
    if (kDebugMode) {
      var object = const JsonDecoder().convert(input);
      var prettyString = const JsonEncoder.withIndent('  ').convert(object);
      log(prettyString);
    }
  }

  // static launchWhatsAppSupport() async {
  //   await FlutterLaunch.launchWhatsapp(
  //       phone: VALUE_WHATSAPP_SUPPORT_NUMBER, message: "");
  // }

  static getLanguageString(String lang) {
    switch (lang) {
      case 'hi':
        return "Hindi";
      case 'en':
        return "English";
      default:
        return "English";
    }
  }

  // static SortEntity getSortEntity(int value) {
  //   switch (value) {
  //     case 0:
  //       return SortEntity(key: "createdOn", value: "1");
  //     case 1:
  //       return SortEntity(key: "createdOn", value: "-1");
  //     default:
  //       return SortEntity(key: "createdOn", value: "1");
  //   }
  // }

  static int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  static String getDefaultCurrencySymbol() {
    return "₹";
  }

  static String longDateFormat = 'dd/MM/yyyy';
  static String shortDateFormat = 'MMM yy';
  static String shortDateWithYear = 'MMM dd, yy';
  static String dateFormatDayMonthYear = 'dd MMM yyyy';
  static String timeFormat = 'HH:mm';

  static String? getFormattedDate(String pattern, String date) {
    final DateTime? parsedDate = DateTime.tryParse(date);
    if (parsedDate == null) {
      return null;
    }
    return DateFormat(pattern).format(parsedDate);
  }
}
