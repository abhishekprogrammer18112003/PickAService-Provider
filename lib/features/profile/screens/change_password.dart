import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_icons.dart';
import 'package:pick_a_service/core/loaded_widget.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/profile/data/profile_provider.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _reNewPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 233, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 235, 233, 255),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Change Password",
            style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.w600)),
        leading: GestureDetector(
            onTap: () => CustomNavigator.pop(context),
            child: Image.asset(AppIcons.backbutton)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Image.asset(
              AppIcons.app_logo,
              color: AppColors.primary,
              height: 43.h,
              width: 56.w,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<ProfileProvider>(
          builder: (context, value, child) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  const Text("New Password"),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _newPasswordController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white, // Set the fill color to white
                        filled: true, // Enable filling
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),

                        hintText: "enter new password",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 199, 199, 199),
                            fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  const Text("Re-enter New Password"),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _reNewPasswordController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white, // Set the fill color to white
                        filled: true, // Enable filling
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),

                        hintText: "Re-enter new password",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 199, 199, 199),
                            fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  !value.isEditLoading
                      ? Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 137, 193, 30),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: GestureDetector(
                              onTap: () {
                                if (_newPasswordController.text ==
                                    _reNewPasswordController.text) {
                                  value.changePassword(
                                      context, _newPasswordController.text);
                                } else {
                                  OverlayManager.showToast(
                                      type: ToastType.Error,
                                      msg: "Password Does not match");
                                }
                              },
                              child: Center(
                                child: Text(
                                  "Save Changes",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              )),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
