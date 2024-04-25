// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:url_launcher/url_launcher.dart';

class NetworkHelpers {
  static Future<void> launchUrl({
    required String url,
    required VoidCallback errorCallback,
  }) async {
    try {
      await url_launcher.launchUrl(
        Uri.parse(url),
        mode: url_launcher.LaunchMode.externalNonBrowserApplication,
      );
    } catch (e) {
      errorCallback();
    }
  }

  static Future<void> launchURLInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
