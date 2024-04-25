import 'package:flutter/material.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_text_styles.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/models/get_tons_model.dart';
import 'package:pick_a_service/features/home/models/tons_model.dart';

class TonsModelDropdown extends StatelessWidget {
  const TonsModelDropdown(
      {Key? key,
      required this.items,
      required this.hintText,
      required this.validator,
      required this.onChanged,
      this.isDisabled = false,
      this.initialValue})
      : super(key: key);

  final List<TonsModel> items;
  final String hintText;
  final String? Function(String?) validator;
  final void Function(int) onChanged;
  final bool isDisabled;
  final TonsModel? initialValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<TonsModel>(
      value: initialValue,
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(
                item.name!,
                style: AppTextStyles.labelStyle.copyWith(
                  color: Colors.black87,
                ),
              ),
            ),
          )
          .toList(),
      // validator: validator,
      onChanged: !isDisabled ? (value) => onChanged(value!.id!) : null,
      decoration: InputDecoration(
        enabled: !isDisabled,
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        disabledBorder: buildBorder(),
        errorBorder: buildBorder(AppColors.error),
        focusedErrorBorder: buildBorder(AppColors.error),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
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
