
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/custom_spacers.dart';
import '../../core/utils/screen_utils.dart';

class CustomRadioTile extends StatelessWidget {
  const CustomRadioTile(
      {Key? key,
      required this.groupValue,
      required this.value,
      required this.onChanged})
      : super(key: key);

  final String groupValue;
  final String value;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 14.h,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _RadioButton(isSelected: value == groupValue),
            CustomSpacers.width10,
            Text(
              value,
              style: AppTextStyles.textStyle16w500Secondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _RadioButton extends StatelessWidget {
  const _RadioButton({Key? key, required this.isSelected}) : super(key: key);

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      height: 25.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.lightestGrey,
          border: Border.all(color: AppColors.lightGrey)),
      padding: EdgeInsets.all(5.w),
      child: isSelected
          ? DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: AppColors.primary,
              ),
            )
          : null,
    );
  }
}
