import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_text_styles.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/models/get_tons_model.dart';

class TonsDropdown extends StatelessWidget {
  const TonsDropdown({
    Key? key,
    required this.items,
    required this.hintText,
    required this.validator,
    required this.onChanged,
    this.isDisabled = false,
    this.initialValue,
  }) : super(key: key);

  final List<GetTonsModel> items;
  final String hintText;
  final String? Function(String?) validator;
  final void Function(int) onChanged;
  final bool isDisabled;
  final GetTonsModel? initialValue;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<GetTonsModel>(
      items: items,
      selectedItem: initialValue,
      itemAsString: (GetTonsModel item) => item.subCategoryNameEn!,
      enabled: !isDisabled,
      onChanged: !isDisabled ? (value) => onChanged(value!.id!) : null,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
          disabledBorder: buildBorder(),
          errorBorder: buildBorder(AppColors.error),
          focusedErrorBorder: buildBorder(AppColors.error),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          filled: true,
          fillColor: AppColors.lightestGrey,
          hintText: hintText,
          hintStyle: AppTextStyles.labelStyle.copyWith(
            color: AppColors.grey,
          ),
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
            hintText: 'Search...',
            hintStyle: AppTextStyles.labelStyle.copyWith(
              color: AppColors.grey,
            ),
          ),
          style: AppTextStyles.labelStyle.copyWith(
            color: Colors.black87,
          ),
        ),
        itemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Text(
              item.subCategoryNameEn!,
              style: AppTextStyles.labelStyle.copyWith(
                color: isSelected ? AppColors.primary : Colors.black87,
              ),
            ),
          );
        },
      ),
    );
  }

  OutlineInputBorder buildBorder([Color color = AppColors.lightGrey]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: color),
    );
  }
}
