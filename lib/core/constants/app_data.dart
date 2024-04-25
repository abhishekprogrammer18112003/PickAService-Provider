import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:pick_a_service/core/app_imports.dart';

import '../helpers/utils.dart';

class AppData {


  static String lang = "en";


  static Color hexToColor(String hexColor) {
    final buffer = StringBuffer();
    if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  //Convert to Argb
  static List<int> hexToRgba(String hexColor) {
    Color color = hexToColor(hexColor);
    return [color.red, color.green, color.blue, (color.alpha * 255).toInt()];
  }

  //Format Date and Time
  static String FormatDate(String a) {
    DateTime dateTime = DateTime.parse(a);

    String formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);

    return formattedDate;
  }

  static String FormatTime(String a) {
    DateTime dateTime = DateTime.parse(a);

    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }





  static Set<String> items = {"cash", "card"};

  static List<Map<String, dynamic>> InvoicePrice = [{"title" : "Intem1", "price" : "price1"}  , {"title" : "Intem1", "price" : "price1"}, {"title" : "Intem1", "price" : "price1"}, {"title" : "Intem1", "price" : "price1"}];
}
