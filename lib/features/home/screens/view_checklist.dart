// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_icons.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/data/home_provider.dart';
import 'package:pick_a_service/features/home/models/accepted_models.dart';
import 'package:pick_a_service/features/home/models/get_checklist_model.dart';
import 'package:pick_a_service/features/home/widgets/orders_widget.dart';
import 'package:pick_a_service/features/home/widgets/tons_dropdown.dart';
import 'package:pick_a_service/features/home/widgets/tons_model_dropdown.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:pick_a_service/ui/molecules/custom_button.dart';
import 'package:pick_a_service/ui/molecules/custom_text_field.dart';
import 'package:provider/provider.dart';

class ViewCheckListScreen extends StatefulWidget {
  AcceptedOrdersModel arguments;
  ViewCheckListScreen({super.key, required this.arguments});

  @override
  State<ViewCheckListScreen> createState() => _ViewCheckListScreenState();
}

class _ViewCheckListScreenState extends State<ViewCheckListScreen> {
  // final ImagePicker _picker = ImagePicker();
  // XFile? _image;
  TextEditingController _tonsController = TextEditingController();
  TextEditingController _modelController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeProvider>(context, listen: false)
          .getChecklistData(widget.arguments.checklistUserTicketId, context);

      _tonsController.text =
          await Provider.of<HomeProvider>(context, listen: false)
              .getChecklistModel[0]
              .SubCategoryNameEn;

      _modelController.text =
          await Provider.of<HomeProvider>(context, listen: false)
              .getChecklistModel[0]
              .modelName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 126, 217, 245),
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 126, 217, 245),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Checklist",
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
        child: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return !value.isGettingChecklist
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CustomSpacers.height80,
                      OrdersWidget(data: widget.arguments),

                      // CustomSpacers.height10,
                      _buildBottom(value.getChecklistModel[0]),

                      value.getChecklistModel[0].imgUrl != ""
                          ? Image.network(
                              value.getChecklistModel[0].imgUrl,
                              height: 300,
                              width: 500,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Return the child (image) if loading is complete
                                } else {
                                  return Center(
                                    child: Text(
                                      "Wait for the image to load...",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ); // Show message while image is loading
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                    child: Text("Error loading image"));
                              },
                            )
                          : Center(child: Text("No image found !")),

                      // CustomSpacers.height60,

                      // Align(
                      //     alignment: Alignment.center,
                      //     child: subCatCat != 0 && modelID != 0 && _image != null
                      //         ? !value.isSaving
                      //             ? CustomButton(
                      //                 strButtonText: "Save Checklist",
                      //                 buttonAction: () {
                      //                   print(_image!.path);
                      //                   // CustomNavigator.pop(context);
                      //                   value.createChecklist(
                      //                       widget.arguments.ticketId,
                      //                       widget.arguments.customerId,
                      //                       subCatCat,
                      //                       modelID,
                      //                       context,
                      //                       widget.arguments , _image!.path);

                      //                   // notificationProvider.Checklist(true);
                      //                   // print(notificationProvider.isChecklist);
                      //                   // CustomNavigator.pop(context);
                      //                 },
                      //                 bgColor: AppColors.primary,
                      //                 textColor: AppColors.secondary,
                      //                 dHeight: 40.h,
                      //                 dWidth: 200.w,
                      //               )
                      //             : Center(
                      //                 child: CircularProgressIndicator(),
                      //               )
                      //         : Container()),

                      CustomSpacers.height35
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }

  _buildBottom(GetChecklistModel a) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Choose the items from the following Checklists- ",
            //   style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.w500),
            // ),
            CustomSpacers.height30,
            // TonsDropdown(
            //     items: value.getTonsList,
            //     hintText: "Tons",
            //     validator: (v) {},
            //     onChanged: (v) {
            //       print(v);
            //       value.getTonsModel(v);
            //       setState(() {
            //         _isModel = true;
            //         subCatCat = v;
            //       });
            //     }),

            Text("Selected Ton",
                style: TextStyle(
                    fontSize: 18.h,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black)),
            CustomSpacers.height10,
            TextField(
              decoration: InputDecoration(
                // labelText: "Search",
                hintText: a.SubCategoryNameEn,
                hintMaxLines: 2,
                hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.black,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
            ),
            CustomSpacers.height40,

            Text("Selected Model",
                style: TextStyle(
                    fontSize: 18.h,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black)),
            CustomSpacers.height10,

            TextField(
              decoration: InputDecoration(
                // labelText: "Search",
                hintText: a.modelName,
                hintMaxLines: 2,
                hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.black,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
            ),
            // CustomButton(strButtonText: value.getChecklistModel.modelName, buttonAction: (){}  , ),

            // _isModel
            //     ? TonsModelDropdown(
            //         items: value.getModelList,
            //         hintText: "Model",
            //         validator: (v) {},
            //         onChanged: (v) {
            //           setState(() {
            //             modelID = v;
            //           });
            //         })
            //     : Container(),
            CustomSpacers.height24
          ],
        ),
      );
}
