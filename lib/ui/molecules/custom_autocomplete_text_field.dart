

import 'package:pick_a_service/core/utils/screen_utils.dart';

import '../../core/app_imports.dart';

import 'custom_text_field.dart';

class CustomAutocompleteTextField extends StatelessWidget {
  const CustomAutocompleteTextField({
    super.key,
    required this.controller,
    required this.validator,
    required this.focusNode,
    required this.options,
    this.hintText,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.prefix,
    this.onSubmitted, 
    this.onChanged,
    this.disabled = false,
  });

  final TextEditingController controller;
  final String? Function(String?) validator;
  final FocusNode focusNode;
  final Set<String> options;
  final String? hintText;
  final String? errorText;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final Widget? prefix;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RawAutocomplete<String>(
          textEditingController: controller,
          focusNode: focusNode,
          optionsBuilder: optionsBuilderHandler,
          optionsViewBuilder: (context, onSelected, options) =>
              optionsViewBuilderHandler(
                  context, onSelected, options, constraints),
          fieldViewBuilder: fieldViewBuilderHandler,
        );
      },
    );
  }

  Iterable<String> optionsBuilderHandler(TextEditingValue value) {
    if (value.text.isEmpty) {
      return const Iterable<String>.empty();
    }

    return options.where(
      (option) => option.toLowerCase().contains(
            value.text.toLowerCase(),
          ),
    );
  }

  Widget optionsViewBuilderHandler(
    BuildContext context,
    void Function(String) onSelected,
    Iterable<String> options,
    BoxConstraints constraints,
  ) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        child: Container(
          margin: EdgeInsets.only(top: 8.h),
          width: constraints.maxWidth,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            color: AppColors.white,
            shadows: [
              BoxShadow(
                color: AppColors.boxShadow,
                blurRadius: 15.r,
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 8.h,
            ),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options.elementAt(index);
              return InkWell(
                onTap: () {
                  onSelected(option);
                  if (onSubmitted != null ) {
                    onSubmitted!(option);
                  }
                }, 
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Text(
                    option,
                    style: AppTextStyles.textStyle16w500Modal,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
      ),
    );
  }

  Widget fieldViewBuilderHandler(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode,
    void Function() _,
  ) {
    return CustomTextField(
      controller: controller,
      focusNode: focusNode,
      disabled: disabled,
      hint: hintText,
      errorText: errorText,
      validator: validator,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      prefix: prefix,
      onChanged: onChanged,
      onSubmitted: onSubmitted, 
    );
  }
}
