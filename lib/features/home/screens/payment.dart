import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_data.dart';
import 'package:pick_a_service/core/constants/app_icons.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:pick_a_service/ui/molecules/custom_button.dart';
import 'package:pick_a_service/ui/molecules/custom_drop_down.dart';
import 'package:pick_a_service/ui/molecules/custom_text_field.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Payment",
              style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.w600)),
          leading: GestureDetector(
              onTap: () => CustomNavigator.pop(context),
              child: Image.asset(AppIcons.backbutton)),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Image.asset(
                AppIcons.app_logo,
                color: AppColors.primary,
                height: 43.h,
                width: 56.w,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomSpacers.height80,
              Row(
                children: [
                  Text(
                    "Price : ",
                    style: TextStyle(
                      fontSize: 24.h,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "25 KD",
                    style: TextStyle(
                        fontSize: 24.h,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  ),
                ],
              ),
              CustomSpacers.height60,
              Text(
                "Mode of payment - ",
                style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomDropdown(
                  items: AppData.items,
                  hintText: "Mode of payment",
                  validator: (v) {},
                  onChanged: (v) {}),
              CustomSpacers.height40,
              Text(
                "Description - ",
                style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomTextField(
                controller: _descriptionController,
                maxLines: 2,
                maxLength: 2,
              ) 

              ,


              CustomSpacers.height36 ,
              Center(child: CustomButton(strButtonText: "Save", buttonAction : (){} , dWidth: 150.w,dCornerRadius: 20.r,))
            ],
          ),
        ));
  }
}
