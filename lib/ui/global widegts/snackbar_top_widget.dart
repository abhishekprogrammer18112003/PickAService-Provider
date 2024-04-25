import 'package:flutter/material.dart';
import 'package:pick_a_service/route/app_pages.dart';
import 'package:pick_a_service/route/custom_navigator.dart';

class SnackBarWidget extends StatelessWidget {
  BuildContext context;
  SnackBarWidget({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomNavigator.pushTo(context, AppPages.notification);// Navigate to notification page
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              'You have a new notification!',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void showTopSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SnackBarWidget(context: context),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
