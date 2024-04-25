

import 'package:pick_a_service/core/loaded_widget.dart';
import 'package:pick_a_service/features/home/data/notification_provider.dart';
import 'package:pick_a_service/route/app_pages.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:shimmer/shimmer.dart';

import '../app_imports.dart';

class UIHelper {
  static showToast(
      {required String msg,
      required ToastType type,
      ToastDuration duration = ToastDuration.medium}) {
    OverlayManager.showToast(type: type, msg: msg, duration: duration);
  }

  static showLoader() {
    OverlayManager.showLoader(opacity: 0.1, color: Colors.red);
  }

  static hideLoader() {
    OverlayManager.hideOverlay();
  }

  static Widget getProgressGhost({height = 0.0, width = 0.0}) {
    return Center(
        child: Shimmer.fromColors(
            baseColor: AppColors.lightBackground,
            highlightColor: AppColors.white,
            period: const Duration(seconds: 2),
            child: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
            )));
  }

  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }


  static void showTopNotification(String msg) {
    Fluttertoast.showToast(
      
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,

      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }



   static void showErrorSnackbar(BuildContext context, String error) {
    final provider = Provider.of<NotificationProvider>(context , listen: false);
    ScaffoldMessenger.of(context).showSnackBar(
    
      SnackBar(
         
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,

        // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: GestureDetector(
        onTap: () {
          provider.notificationBtnCicked();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          CustomNavigator.pushTo(context, AppPages.notification); // Navigate to notification page
        },
        child: Container(child: Text(error))
      ),
        duration: Duration(seconds: 3),
         // Adjust the duration as needed
        
      ),
    );
  }
}
