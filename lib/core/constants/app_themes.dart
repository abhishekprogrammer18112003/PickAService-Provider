

import '../app_imports.dart';
import 'app_colors.dart';

class AppThemes {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: "Heebo",
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: AppColors.white,
      iconTheme: IconThemeData(
        color: AppColors.primaryText,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.primary,
        fontFamily: 'Heebo',
        fontWeight: FontWeight.w700,
        fontSize: 24,
        height: 36 / 24,
      ),
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(VALUE_ACTION_BUTTON_CORNERRAIUS),
        ),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
    dividerTheme: const DividerThemeData(
      space: 0.0,
      color: AppColors.lightGrey,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        // textStyle: AppTextStyles.textStyle16w400Tertiary,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      elevation: 0.0,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
