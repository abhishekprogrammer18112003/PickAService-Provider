import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/screen_utils.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {required this.controller,
      this.validator,
      this.focusNode,
      this.prefix,
      this.suffix,
      this.textInputAction,
      this.maxLength,
      this.inputFormatters,
      this.keyboardType,
      this.hint,
      this.label,
      this.maxLines,
      this.minLines,
      this.errorText,
      this.onChanged,
      // this.onSubmitted,
      this.autoFocus = false,
      this.isRequired = false,
      this.obscureText = false,
      this.obscuringCharacter = '•',
      this.disabled = false,
      this.fillColor = AppColors.lightestGrey,
      this.leftPadding = 19.0,
      this.textCapitalization = TextCapitalization.none,
      this.scrollPadding,
      this.onSubmitted,
      this.borderRadius = 10.0,
      Key? key})
      : super(key: key);

  final String? errorText;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? hint;
  final String? label;
  final bool autoFocus;
  final bool isRequired;
  final bool obscureText;
  final String obscuringCharacter;
  final ValueChanged<String>? onChanged;
  // final ValueChanged<String>? onSubmitted;
  final bool disabled;
  final Color fillColor;
  final EdgeInsets? scrollPadding;
  final double leftPadding;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onSubmitted;
  final double borderRadius;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final StreamController<bool> _focusChangeStream = StreamController<bool>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: widget.errorText != null && widget.errorText!.isNotEmpty
      //     ? 80.h
      //     : 70.h,
      child: Column(
        children: [
          StreamBuilder<bool>(
              stream: _focusChangeStream.stream,
              initialData: false,
              builder: (context, snapshot) {
                bool focused = snapshot.data!;
                return Container(
                  decoration: const BoxDecoration(),
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      _focusChangeStream.add(hasFocus);
                    },
                    child: TextFormField(
                      maxLines: widget.maxLines,
                      scrollPadding: widget.scrollPadding ??
                          const EdgeInsets.only(bottom: 110),
                      minLines: widget.minLines,
                      onChanged: widget.onChanged,
                      onFieldSubmitted: widget.onSubmitted,
                      textInputAction: widget.textInputAction,
                      // onSubmitted: widget.onSubmitted,
                      controller: widget.controller,
                      validator: widget.validator,
                      enabled: !widget.disabled,
                      cursorColor: AppColors.primary,
                      autofocus: widget.autoFocus,
                      focusNode: widget.focusNode,
                      inputFormatters: widget.inputFormatters,
                      keyboardType: widget.keyboardType,
                      textCapitalization: widget.textCapitalization,
                      maxLength: widget.maxLength,
                      obscureText: widget.obscureText,
                      obscuringCharacter: widget.obscuringCharacter,
                      style: AppTextStyles.labelStyle
                          .copyWith(color: Colors.black87),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: focused ? null : widget.fillColor,
                        hintStyle: const TextStyle(
                            color: AppColors.grey, fontWeight: FontWeight.w400),
                        errorStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        counterText: "",
                        isDense: true,
                        border: buildBorder(),
                        enabledBorder: buildBorder(),
                        focusedBorder: buildBorder(AppColors.primary),
                        disabledBorder: buildBorder(),
                        errorBorder: buildBorder(AppColors.error),
                        focusedErrorBorder: buildBorder(AppColors.error),
                        hintText: widget.hint,
                        errorText: widget.errorText,
                        // labelText: widget.label,
                        label: widget.label != null
                            ? RichText(
                                text: TextSpan(
                                    text: widget.label,
                                    style: AppTextStyles.defaultTextStyle,
                                    children: [
                                      if (widget.isRequired)
                                        const TextSpan(
                                            text: ' *',
                                            style:
                                                TextStyle(color: AppColors.red))
                                    ]),
                              )
                            : null,
                        labelStyle: AppTextStyles.labelStyle,

                        contentPadding: const EdgeInsets.all(16),
                        prefixIcon: widget.prefix,
                        suffixIcon: widget.suffix,
                        suffixIconColor: AppColors.grey,
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  OutlineInputBorder buildBorder([Color color = AppColors.lightGrey]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: color),
    );
  }
}
