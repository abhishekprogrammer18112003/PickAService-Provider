import 'package:flutter/material.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_icons.dart';
import 'package:pick_a_service/core/utils/custom_spacers.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/data/home_provider.dart';
import 'package:pick_a_service/features/profile/data/profile_provider.dart';
import 'package:pick_a_service/features/profile/screens/edit_profile_data.dart';
import 'package:pick_a_service/route/app_pages.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:pick_a_service/ui/molecules/custom_button.dart';
import 'package:provider/provider.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<ProfileProvider>(context, listen: false)
          .getPersonalData(context);

      final provider = Provider.of<ProfileProvider>(context, listen: false);
      _nameController.text = provider.profileDataModel["FullName"];
      _phoneNoController.text = provider.profileDataModel["PhoneNo"];
      _emailController.text = provider.profileDataModel["email"];

      print(_phoneNoController.text);
      print(_emailController.text);

    });
  }

  bool _isEditProfile = false;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
      final provider = Provider.of<ProfileProvider>(context, listen: false);

    return RefreshIndicator(
      onRefresh: () async{
        await provider.getPersonalData(context);
      },
      child: GestureDetector(
        onTap: () {
          // Close the keyboard and unfocus text field when tapping anywhere outside
          _focusNode.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text("PERSONAL DATA",
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
          body: Consumer<ProfileProvider>(
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
                          Center(
                            child: CircleAvatar(
                              radius: 50.r,
                              backgroundImage: value.profileDataModel["Pic"] !=
                                      ""
                                  ? NetworkImage(value.profileDataModel["Pic"])
                                  : null,
                              backgroundColor: AppColors.black,
                              child: value.profileDataModel["Pic"] == ""
                                  ? Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.white,
                                    )
                                  : null,
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
                                  offset:
                                      Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              // focusNode: _focusNode,
                              controller: _nameController,
                              readOnly: true,
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
                                  offset:
                                      Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              // focusNode: _focusNode,
                              controller: _phoneNoController,
                              readOnly: true,
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
      
                                suffixIcon:
                                    value.profileDataModel["isPhoneVerified"] ==
                                            "1"
                                        ? Icon(Icons.verified)
                                        : Container(),
      
                                hintText: _phoneNoController.text,
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 199, 199, 199),
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          CustomSpacers.height30,
      
                          //===================EMAIL -=======================
                          const Text("Email"),
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
                                  offset:
                                      Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              // focusNode: _focusNode,
                              controller: _emailController,
                              readOnly: true,
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
                                suffixIcon:
                                    value.profileDataModel["isEmailVerified"] ==
                                            "1"
                                        ? Icon(Icons.verified)
                                        : Icon(Icons.check , color: Colors.transparent,),
      
                                hintText: _emailController.text,
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 199, 199, 199),
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          CustomSpacers.height48,
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

  _buildButtons() => Consumer<ProfileProvider>(
    builder: (context, value, child) => 
   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSpacers.height40,
            Center(
                child: CustomButton(
                    strButtonText: "Edit profile",
                    buttonAction: () {
                      _navigate(context);
                    },
                    dHeight: 50.h,
                    dWidth: 150.w,
                    textStyle: TextStyle(
                        fontSize: 14.h,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400),
                    dCornerRadius: 15.r,
                    bgColor: Colors.green)),
            CustomSpacers.height20,
            !_isEditProfile
                ? Center(
                    child: CustomButton(
                    strButtonText: "Change Password",
                    buttonAction: () {
                      CustomNavigator.pushTo(context, AppPages.changePassword).then((v){
                        value.getPersonalData(context);
                      });
                    },
                    dHeight: 50.h,
                    dWidth: 150.w,
                    textStyle: TextStyle(
                        fontSize: 14.h,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400),
                    dCornerRadius: 15.r,
                    bgColor: Colors.blue,
                  ))
                : Container(),
          ],
        ),
  );

  void _navigate(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
              opacity: animation,
              child: EditProfileDataPage(data: provider.profileDataModel));
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    ).then((v){
      provider.getPersonalData(context);
    });
  }
}
