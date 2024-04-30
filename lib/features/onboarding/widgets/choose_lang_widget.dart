import 'package:flutter/material.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_data.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/core/utils/custom_spacers.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/language_provider.dart';
import 'package:pick_a_service/main.dart';
import 'package:pick_a_service/ui/molecules/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ChooseLangWidget extends StatefulWidget {
  void Function(String) lang ;
   ChooseLangWidget({super.key , required this.lang});

  @override
  State<ChooseLangWidget> createState() => _ChooseLangWidgetState();
}

class _ChooseLangWidgetState extends State<ChooseLangWidget> {
  String selectedLang = "en";
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageChangeProvider>(
      builder: (context, value, child) => 
       Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.chooseyourlanguage,
                style: TextStyle(
                    fontSize: 17.h,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary),
              ),
            ),
            CustomSpacers.height24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    strButtonText: "English",
                    buttonAction: () {
                      setState(() {
                      selectedLang = "en"; 
                      value.changeLanguage(Locale('en'));
                      lang = 'en';
                      widget.lang(lang);
                      
                        
                      // Set selected language to English
                    });
                    },
                    bgColor:selectedLang == "en" ? AppColors.secondary : AppColors.tertiary,
                    dHeight: 58.h,
                    dWidth: 138.w,
                    textStyle: TextStyle(
                        color:selectedLang == "en" ? AppColors.primary : AppColors.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.h),
                    dCornerRadius: 10.r,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    strButtonText: "Arabic",
                    buttonAction: () {
                      setState(() {
                      selectedLang = "ar";
                      value.changeLanguage(Locale('ar'));
                  
                      // SharedPreferencesManager.setString( "lang" ,  "ar");
                      // lang = SharedPreferencesManager.getString("lang");
                      lang = 'ar';
                      widget.lang(lang);
                       // Set selected language to Arabic
                    });
                    },
                    bgColor: selectedLang == "ar" ?  AppColors.secondary : AppColors.tertiary,
                    dHeight: 58.h,
                    dWidth: 138.w,
                    textStyle: TextStyle(
                        color:  selectedLang == "ar" ?AppColors.primary : AppColors.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.h),
                    dCornerRadius: 10.r,
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
