import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppFontFamily {
  // static const String lato = 'Lato';
  // static const String poppins = 'Poppins';
  // static const String heebo = 'Heebo';
}

class AppTextStyles {
  static const subTextStyle = TextStyle(
      fontSize: 32,
      color: AppColors.primary,
      // fontFamily: "Lato",
      fontWeight: FontWeight.w800);
  static const subTextStyle16_500 = TextStyle(
      fontSize: 16, color: AppColors.primary, fontWeight: FontWeight.w500);
  static const subTextStyle16_400 = TextStyle(
      fontSize: 16, color: AppColors.primary, fontWeight: FontWeight.w400);

  static const defaultTextStyle = TextStyle(
      fontSize: 25,
      color: AppColors.primaryText,
      fontWeight: FontWeight.w400,
      fontFamily: "Poppins");
  static const defaultTextStyle15_400 = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.primaryText);
  static const defaultTextStyle15_400_PRIMARY = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.primary);
  static const labelStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.grey);
  static const buttonTextStyle = TextStyle(
      color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w600);

  static const textStyle18w500Secondary = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );

  static const textStyleLato12w800Primary = TextStyle(
    fontFamily: 'Lato',
    fontSize: 12,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
  );

  //HEEBO FONT STYLE ALL VARIANT
  static const textStyleHeebo14w500Primary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );
  static const textStyleHeebo14w500Secondary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static const textStyleHeebo14w500Tertiary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static const textStyleHeebo14w400Tertiary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static const textStyleHeebo16w400Secondary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
  static const textStyleHeebo16w500Secondary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static const textStyleHeebo24w700Tertiary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Color.fromARGB(237, 255, 255, 255),
  );
  static const textStyleHeebo24w700Secondary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  static const textStyleHeebo24w700Primary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );
  static const textStyleHeebo22w700Primary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );
  static const textStyleHeebo22w700Secondary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static const textStyleHeebo16w500Primary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
  static const textStyleHeebo30w800Primary = TextStyle(
    fontFamily: 'Heebo',
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
  );
  static const textStyle16w500Primary2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryBorder,
  );

  static const textStyle16w500Modal = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.modalText,
  );

  static const textStyle16w500Secondary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );
  static TextStyle textStyle14w400Secondary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText.withOpacity(0.5),
  );
  static TextStyle textStyle14w500Secondary = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );

  static const textStyle16w500Tertiary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.tertiaryText,
  );

  static const textStyleLato12w800Secondary = TextStyle(
    fontFamily: 'Lato',
    fontSize: 12,
    fontWeight: FontWeight.w800,
    color: AppColors.secondaryText,
  );

  static const textStyle12w400Primary2 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryBorder,
  );

  static const textStyle12w400Modal = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.modalText,
  );

  static const textStyle12w400Tertiary = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.tertiaryText,
  );

  static const styleForToast =
      TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400);

  static const textStyle12w400Secondary = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  );

  static const textStyle12w400Black = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const textStyleLato10w400 = TextStyle(
    fontFamily: 'Lato',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.tertiaryText,
  );

  static const textStyleLato18w800Secondary = TextStyle(
    fontFamily: 'Lato',
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.secondaryText,
  );

  static const textStyleLato22w800 = TextStyle(
    fontFamily: 'Lato',
    fontSize: 22,
    fontWeight: FontWeight.w800,
  );

  static const textStyle10w500Secondary = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );

  static const textStyleLato32w800Primary = TextStyle(
    fontFamily: 'Lato',
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
  );

  static const textStyle16w400Tertiary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.tertiaryText,
  );

  static const textStyle12w400Primary = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  static const textStyle24w700Secondary = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.secondaryText,
  );

  static const textStyle24w700Primary = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static const textStyle14w500Black = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const textStyleLato14w500Tertiary = TextStyle(
    fontFamily: 'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.tertiaryText,
  );

  static const textStyleLato14w500Secondary = TextStyle(
    fontFamily: 'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );

  static const fs14Fw500FfLato = TextStyle(
    fontFamily: 'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const textStyleLato14w500White = TextStyle(
    fontFamily: 'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const textStyleLato14w500Primary = TextStyle(
    fontFamily: 'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  // static const textStyle16w600Secondary = TextStyle(
  //   fontSize: 16,
  //   fontWeight: FontWeight.w600,
  //   color: AppColors.secondaryText,
  // );

  static const textStyle18w600Primary = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const textStyle20w600Black = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const textStyle10w700White = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const textStyleLato16w800Primary2 = TextStyle(
    fontFamily: 'Lato',
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryBorder,
  );

  // static const textStyleLato16w800Secondary = TextStyle(
  //   fontFamily: 'Lato',
  //   fontSize: 16,
  //   fontWeight: FontWeight.w800,
  //   color: AppColors.secondaryText,
  // );

  static const textStyleLato16w800White = TextStyle(
    fontFamily: 'Lato',
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  // static const textStyleLato10w500Secondary = TextStyle(
  //   fontFamily: 'Lato',
  //   fontSize: 10,
  //   fontWeight: FontWeight.w500,
  //   color: AppColors.tertiaryText,
  // );

  // static const textStyleLato10w500Tertiary = TextStyle(
  //   fontFamily: 'Lato',
  //   fontSize: 10,
  //   fontWeight: FontWeight.w500,
  //   color: AppColors.tertiaryText,
  // );

  static const textStyleLato10w500Primary = TextStyle(
    fontFamily: 'Lato',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  static const textStyleLato40w700Primary2 = TextStyle(
    fontFamily: 'Lato',
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 48 / 40,
    color: AppColors.primaryBorder,
  );

  static const textStyleLato30w700White = TextStyle(
    fontFamily: 'Lato',
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 36 / 30,
    color: Colors.white,
  );

  static const textStyle14w600White = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // static const textStyle14w600Tertiary = TextStyle(
  //   fontSize: 14,
  //   fontWeight: FontWeight.w600,
  //   color: AppColors.tertiaryText,
  // );

  // static const textStyle18w600Secondary = TextStyle(
  //   fontSize: 18,
  //   fontWeight: FontWeight.w600,
  //   color: AppColors.secondaryText,
  // );

  static const fs18Fw400 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const fs14Fw400 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const fs18Fw800Lh27 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    height: 27 / 18,
  );

  static const fs12Fw400Lh18 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 18 / 12,
  );

  static const fs12Fw800Lh14 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    height: 14 / 12,
  );

  static const fs16Fw800Lh20 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    height: 20 / 16,
  );

  static const fs10Fw500Lh12 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 12 / 10,
  );

  static const fs14Fw400Lh20 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
  );

  static const fs14Fw500Lh16 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 16 / 14,
  );

  static const fs18Fw500Lh20 = TextStyle(
    fontSize: 18,
    height: 20 / 18,
    fontWeight: FontWeight.w500,
  );
}
