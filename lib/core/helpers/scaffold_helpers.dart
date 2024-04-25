// import 'package:image_picker/image_picker.dart';

import 'package:pick_a_service/core/utils/screen_utils.dart';

import '../../route/custom_navigator.dart';

import '../app_imports.dart';

class ScaffoldHelpers {
  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            color: AppColors.white,
          ),
          // padding:
          //     EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.65,
          ),
          child: child,
        ),
      ),
    );
  }

  static Future<DateTime?> showCalender(BuildContext context) async {
    DateTime? dateTime;
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          insetPadding: EdgeInsets.all(22.w),
          child: CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(1970, 1, 1),
            lastDate: DateTime.now(),
            onDateChanged: (value) {
              dateTime = value;
              CustomNavigator.pop(context);
            },
          ),
        );
      },
    );
    return dateTime;
  }

  static Future<void> showConfirmDialog(
    BuildContext context,
    VoidCallback confirmHandler,
    String title,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        title: Text(
          title,
          // style: AppTextStyles.fs18Fw500Lh20.copyWith(
          //   color: AppColors.secondaryText,
          //   fontFamily: AppFontFamily.lato,
          // ),
        ),
        actions: [
          TextButton(
            onPressed: () => CustomNavigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              CustomNavigator.pop(context);
              confirmHandler();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  static Future<void> showCustomDialog(
    BuildContext context,
    Widget content,
  ) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        insetPadding: const EdgeInsets.all(VALUE_STANDARD_SCREEN_PADDING),
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            color: AppColors.white,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 20.h,
          ),
          child: content,
        ),
      ),
    );
  }

  // static Future<XFile?> showImageSelectionBottomSheet(
  //   BuildContext context,
  //   VoidCallback? removeImageHandler,
  // ) async {
  //   return await ScaffoldHelpers.showBottomSheet<XFile?>(
  //     context: context,
  //     child: ImageSelectorBottomSheet(removeImageHandler: removeImageHandler),
  //   );
  // }
}
