import 'package:flutter/material.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/screen_utils.dart';

import '../../core/constants/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {Key? key,
      required this.items,
      required this.hintText,
      required this.validator,
      required this.onChanged,
      this.isDisabled = false,
      this.initialValue})
      : super(key: key);

  final Set<String> items;
  final String hintText;
  final String? Function(String?) validator;
  final void Function(String?) onChanged;
  final bool isDisabled;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item.toLowerCase(),
              child: Text(
                item,
                style: AppTextStyles.labelStyle.copyWith(
                  color: Colors.black87,
                ),
              ),
            ),
          )
          .toList(),
      validator: validator,
      onChanged: !isDisabled ? (value) => onChanged(value) : null,
      decoration: InputDecoration(
        enabled: !isDisabled,
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        disabledBorder: buildBorder(),
        errorBorder: buildBorder(AppColors.error),
        focusedErrorBorder: buildBorder(AppColors.error),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14.w,
        ),
        filled: true,
        fillColor: AppColors.lightestGrey,
        hintText: hintText,
        hintStyle: AppTextStyles.labelStyle.copyWith(
          color: AppColors.grey,
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      iconEnabledColor: AppColors.grey,
      dropdownColor: AppColors.white,
      borderRadius: BorderRadius.circular(8.r),
      style: AppTextStyles.labelStyle.copyWith(
        color: Colors.black87,
      ),
      menuMaxHeight: 400.h,
    );
  }

  OutlineInputBorder buildBorder([Color color = AppColors.lightGrey]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: color),
    );
  }
}
