import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_icons.dart';
import 'package:pick_a_service/core/constants/value_constants.dart';
import 'package:pick_a_service/core/loaded_widget.dart';
import 'package:pick_a_service/core/utils/custom_spacers.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/data/home_provider.dart';
import 'package:pick_a_service/features/profile/data/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:pick_a_service/ui/molecules/custom_button.dart';
import 'package:provider/provider.dart';

class EditProfileDataPage extends StatefulWidget {
  Map<String, dynamic> data;
  EditProfileDataPage({super.key, required this.data});

  @override
  State<EditProfileDataPage> createState() => _EditProfileDataPageState();
}

class _EditProfileDataPageState extends State<EditProfileDataPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.data["FullName"];
    _phoneNoController.text = widget.data["PhoneNo"];
    _emailController.text = widget.data["email"];
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  bool _isEditProfile = true;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close the keyboard and unfocus text field when tapping anywhere outside
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("EDIT PROFILE",
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
        body: SingleChildScrollView(
          child: Consumer<ProfileProvider>(
            builder: (context, value, child) {
              return !value.isPersonalLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSpacers.height20,
                          // =============pprofile photo ====================
                          Center(
                            child: CircleAvatar(
                              radius: 50.r,
                              backgroundImage: _image != null
                                  ? FileImage(File(_image!.path))
                                      as ImageProvider<Object>?
                                  : NetworkImage(widget.data["Pic"]),
                              backgroundColor: AppColors.black,
                              child: GestureDetector(
                                onTap: getImageFromGallery,
                                // child :widget.data["Pic"] == "" ? Icon(Icons.person , size: 50,) : Container(),
                              ),
                            ),
                          ),

                          CustomSpacers.height20,

                          //=============== NAME =======================
                          const Text("Name"),
                          CustomSpacers.height10,
                          Container(
                            height: 50.h,
                            width: 350.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              focusNode: _nameFocusNode,
                              controller: _nameController,
                              readOnly: _isEditProfile ? false : true,
                              // readOnly: true,
                              decoration: InputDecoration(
                                fillColor:
                                    Colors.white, // Set the fill color to white
                                filled: true, // Enable filling
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                ),

                                hintText: _nameController.text,
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 199, 199, 199),
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          CustomSpacers.height30,

                          //==================PHONE NUMBER=======================
                          const Text("Phone Number"),
                          CustomSpacers.height10,
                          Container(
                            height: 50.h,
                            width: 350.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              focusNode: _focusNode,
                              controller: _phoneNoController,
                              readOnly: _isEditProfile ? false : true,
                              decoration: InputDecoration(
                                fillColor:
                                    Colors.white, // Set the fill color to white
                                filled: true, // Enable filling
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                ),

                                hintText: value.profileDataModel["PhoneNo"],
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 199, 199, 199),
                                    fontSize: 14),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length != 8) {
                                  return 'Please enter the correct Phone Number';
                                }

                                return null;
                              },
                            ),
                          ),
                          CustomSpacers.height30,

                          _buildButtons(),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }

  bool otp = false;
  TextEditingController _otpController = TextEditingController();
  _buildButtons() => Consumer<ProfileProvider>(
        builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              otp
                  ? TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter OTP',
                        border: OutlineInputBorder(),
                      ),
                      maxLength: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter OTP';
                        }

                        return null;
                      },
                    )
                  : Container(),
              CustomSpacers.height40,
              Center(
                  child: !value.isEditLoading
                      ? CustomButton(
                          strButtonText: !otp ? "Edit profile" : "Save Changes",
                          buttonAction: () async {
                            if (!otp &&
                                widget.data["FullName"] !=
                                    _nameController.text &&
                                widget.data["PhoneNo"] !=
                                    _phoneNoController.text &&
                                _phoneNoController.text.length == 8) {
                              await value.editPersonalDataWithoutPhone(
                                  context,
                                  _nameController.text,
                                  _image != null
                                      ? _image!.path
                                      : "");

                              await value.editPersonalDataWithPhone(
                                  context,
                                  _phoneNoController.text,
                                  _nameController.text);
                              setState(() {
                                otp = true;
                              });
                            } else if (!otp &&
                                widget.data["PhoneNo"] ==
                                    _phoneNoController.text) {
                              await value.editPersonalDataWithoutPhone(
                                  context,
                                  _nameController.text,
                                  _image != null
                                      ? _image!.path
                                      : "");
                              CustomNavigator.pop(context);
                              Navigator.pop(context);
                            } else if (!otp &&
                                widget.data["PhoneNo"] !=
                                    _phoneNoController.text &&
                                _phoneNoController.text.length == 8) {
                              await value.editPersonalDataWithPhone(
                                  context,
                                  _phoneNoController.text,
                                  _nameController.text);

                              setState(() {
                                otp = true;
                              });
                            }

                           
                              await value.editPersonalDataWithoutPhone(
                                  context,
                                  _nameController.text,
                                  _image != null
                                      ? _image!.path
                                      : "");
                            
                            
                            if (_phoneNoController.text.length != 8) {
                              OverlayManager.showToast(
                                  type: ToastType.Alert,
                                  msg: "Enter the correct Phone Number");
                            }

                            if (otp) {
                              value.UpdataPhoneData(context,
                                  _otpController.text, _phoneNoController.text);
                            }
                          },
                          dHeight: 50.h,
                          dWidth: 200.w,
                          textStyle: TextStyle(
                              fontSize: 16.h,
                              color: AppColors.white,
                              fontWeight: FontWeight.w400),
                          dCornerRadius: 15.r,
                          bgColor: Colors.green)
                      : CircularProgressIndicator()),
            ],
          );
        },
      );
}
