import 'package:flutter/material.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/value_constants.dart';
import '../../core/utils/screen_utils.dart';
import '../atoms/bounce_widget.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/custom_spacers.dart';

enum ButtonType { PRIMARY, SECONDARY, OUTLINED, SUBACTION }

class CustomButton extends StatelessWidget {
  final String strButtonText;
  final VoidCallback buttonAction;
  final ButtonType buttonType;
  final double dCornerRadius;
  final bool isLoading;
  final double dHeight;
  final double dWidth;
  final Color borderColor;
  final Color bgColor;
  final Color textColor;
  final TextAlign buttonTextAlignment;
  final bool bIcon;
  final bool bIconLeft; // By default left will be true
  final Widget? buttonIcon;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle? textStyle;

  const CustomButton(
      {Key? key,
      required this.strButtonText,
      required this.buttonAction,
      this.dCornerRadius = VALUE_PRIMARY_BUTTON_CORNER_RADIUS,
      this.borderColor = Colors.transparent,
      this.buttonType = ButtonType.PRIMARY,
      this.isLoading = false,
      this.bgColor = AppColors.primary,
      this.textColor = AppColors.white,
      this.buttonTextAlignment = TextAlign.center,
      this.dHeight = VALUE_ACTION_PRIMARY_BUTTON_HEIGHT,
      this.dWidth = VALUE_ACTION_PRIMARY_BUTTON_HEIGHT,
      this.bIconLeft = true,
      this.bIcon = false,
      this.buttonIcon,
      this.textStyle = AppTextStyles.buttonTextStyle,
      this.mainAxisAlignment = MainAxisAlignment.spaceAround})
      : super(key: key);

  factory CustomButton.icon(
      {String strButtonText = '',
      required VoidCallback buttonAction,
      required bool bIconLeft,
      Color borderColor = Colors.transparent,
      required Widget? icon,
      Color bgColor = AppColors.red,
      Color textColor = AppColors.white,
      double dCornerRadius = VALUE_PRIMARY_BUTTON_CORNER_RADIUS}) {
    return CustomButton(
        strButtonText: strButtonText,
        buttonAction: buttonAction,
        buttonIcon: icon,
        bIconLeft: bIconLeft,
        bIcon: true,
        bgColor: bgColor,
        textColor: textColor,
        textStyle: AppTextStyles.buttonTextStyle
            .copyWith(color: textColor, fontWeight: FontWeight.w600),
        dCornerRadius: dCornerRadius,
        borderColor: borderColor);
  }

  Widget _buildPrimary() {
    return Container(
        height: dHeight,
        width: dWidth,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(dCornerRadius),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (bIcon == true && bIconLeft == true)
                Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(right: 10),
                    child: buttonIcon!),
              isLoading
                  ? const SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      strButtonText,
                      textAlign: buttonTextAlignment,
                      style: textStyle,
                    ),
              if (bIcon == true && bIconLeft == false) CustomSpacers.width8,
              if (bIcon == true && bIconLeft == false) buttonIcon!,
            ],
          ),
        ));
  }

  _buildOutLined() {
    return Container(
        height: dHeight.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dCornerRadius),
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (bIcon == true && bIconLeft == true)
                Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(right: 10),
                    child: buttonIcon!),
              isLoading
                  ? const SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      strButtonText,
                      textAlign: buttonTextAlignment,
                      style: textStyle!.copyWith(color: AppColors.primary),
                    ),
              if (bIcon == true && bIconLeft == false) CustomSpacers.width8,
              if (bIcon == true && bIconLeft == false) buttonIcon!,
            ],
          ),
        ));
  }

  Widget getButton(ButtonType type) {
    switch (type) {
      case ButtonType.PRIMARY:
        return _buildPrimary();
      case ButtonType.OUTLINED:
        return _buildOutLined();
      default:
        return _buildPrimary();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      duration: const Duration(milliseconds: 180),
      scaleFactor: 1.5,
      onPressed: () {
        if (!isLoading) {
          buttonAction();
        }
      },
      child: getButton(buttonType),
    );
  }
}
