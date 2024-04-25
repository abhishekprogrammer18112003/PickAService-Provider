import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';

class CustomTextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  bool obsecure;
  String hintText;
  IconData icon;
  String validator;
  CustomTextFieldWidget({super.key, required this.controller , required this.hintText , required this.icon , required this.validator,  required this.obsecure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
        // prefixIcon: Icon(icon),
        prefixIcon: Icon(icon),
        hintText: hintText,
        filled: true,
        fillColor: AppColors.secondary,
         
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validator;
        }
       
        return null;
      },
    );
  }
}
