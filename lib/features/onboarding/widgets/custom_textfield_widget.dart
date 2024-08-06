import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool obsecure;
  final String hintText;
  final IconData icon;
  final String validator;

  CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.validator,
    required this.obsecure,
  });

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obsecure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isObscure,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefixIcon: Icon(widget.icon),
        hintText: widget.hintText,
        filled: true,
        fillColor: AppColors.secondary,
        suffixIcon: widget.obsecure
            ? IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return widget.validator;
        }
        return null;
      },
    );
  }
}
