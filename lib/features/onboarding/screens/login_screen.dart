// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/constants/app_images.dart';
import 'package:pick_a_service/core/loaded_widget.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/onboarding/data/provider/login_provider.dart';
import 'package:pick_a_service/features/onboarding/widgets/choose_lang_widget.dart';
import 'package:pick_a_service/features/onboarding/widgets/custom_textfield_widget.dart';
import 'package:pick_a_service/notification_service.dart';
import 'package:pick_a_service/route/app_pages.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:pick_a_service/ui/molecules/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String lang = "en";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.login_bg_image,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          _buildPage(context),
        ],
      ),
    );
  }

  _buildPage(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 37.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.height70,
            // Icons
            Container(
              height: 42.h,
              width: 500.w,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  AppImages.pick_a_service,
                  height: 42.h,
                  width: 266.w,
                ),
              ),
            ),
            CustomSpacers.height160,
            CustomSpacers.height10,

            // Text field email
            CustomTextFieldWidget(
              obsecure: false,
              controller: _emailController,
              hintText: AppLocalizations.of(context)!.email,
              icon: Icons.email_outlined,
              validator: "Enter your email",
            ),
            CustomSpacers.height16,

            // Text field password
            CustomTextFieldWidget(
              obsecure: true,
              controller: _passwordController,
              hintText: AppLocalizations.of(context)!.password,
              icon: Icons.lock_outline,
              validator: "Enter your password",
            ),
            CustomSpacers.height16,

            // Custom button
            Center(
              child: CustomButton(
                strButtonText: AppLocalizations.of(context)!.login,
                buttonAction: () {
                  FocusScope.of(context).unfocus();
                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    OverlayManager.showToast(
                        type: ToastType.Alert, msg: "please enter data!");
                  } else {
                    loginProvider.getLoginData(
                        _emailController.text, _passwordController.text, context, lang);
                  }
                },
                isLoading: loginProvider.isLoading,
                dHeight: 58.h,
                dWidth: 302.w,
                dCornerRadius: 10.r,
                bgColor: Colors.blue,
                textColor: AppColors.secondary,
              ),
            ),
            CustomSpacers.height80,
            CustomSpacers.height38,
            ChooseLangWidget(
              lang: (p0) {
                setState(() {
                  lang = p0;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
