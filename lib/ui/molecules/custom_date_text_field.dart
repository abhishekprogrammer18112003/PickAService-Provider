import 'package:flutter/material.dart';

import '../../core/helpers/scaffold_helpers.dart';
import '../../core/helpers/utils.dart';
import 'custom_text_field.dart';

class CustomDateTextField extends StatelessWidget {
  const CustomDateTextField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final TextEditingController formattedController = TextEditingController(
      text: Utils.getFormattedDate(
        Utils.longDateFormat,
        controller.text,
      ),
    );

    return CustomTextField(
      controller: formattedController,
      validator: validator,
      hint: hintText,
      isRequired: true,
      keyboardType: TextInputType.none,
      suffix: GestureDetector(
        onTap: () async {
          final DateTime? dateTime =
              await ScaffoldHelpers.showCalender(context);
          if (dateTime == null) {
            return;
          }
          controller.text = dateTime.toIso8601String();
          formattedController.text = Utils.getFormattedDate(
                Utils.longDateFormat,
                controller.text,
              ) ??
              formattedController.text;
        },
        child: const Icon(Icons.calendar_month_outlined),
      ),
    );
  }
}
