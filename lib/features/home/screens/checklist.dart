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
import 'package:pick_a_service/features/home/widgets/orders_widget.dart';
import 'package:pick_a_service/features/home/widgets/tons_dropdown.dart';
import 'package:pick_a_service/features/home/widgets/tons_model_dropdown.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:pick_a_service/ui/molecules/custom_button.dart';
import 'package:provider/provider.dart';

class CheckListScreen extends StatefulWidget {
  AcceptedOrdersModel arguments;
  CheckListScreen({super.key, required this.arguments});

  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeProvider>(context, listen: false)
          .getTons(widget.arguments.categoryId, widget.arguments.subcategoryId);
    });
  }

  Future getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future getImagefromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  bool _isModel = false;
  int subCatCat = 0;
  int modelID = 0;
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CustomSpacers.height80,
                OrdersWidget(data: widget.arguments),

                CustomSpacers.height20,
                _buildBottom(),

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _image == null
                          ? Text('No image selected.')
                          : Image.file(
                              File(_image!.path),
                              height: 200,
                            ),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        onPressed: getImagefromCamera,
                        child: Text('Take Photo'),
                      ),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        onPressed: getImageFromGallery,
                        child: Text('Upload from Gallery'),
                      ),
                    ],
                  ),
                ),

                CustomSpacers.height60,

                Align(
                    alignment: Alignment.center,
                    child: subCatCat != 0 && modelID != 0 && _image != null
                        ? !value.isSaving
                            ? CustomButton(
                                strButtonText: "Save Checklist",
                                buttonAction: () {
                                  print(_image!.path);
                                  // CustomNavigator.pop(context);
                                  value.createChecklist(
                                      widget.arguments.ticketId,
                                      widget.arguments.customerId,
                                      subCatCat,
                                      modelID,
                                      context,
                                      widget.arguments , _image!.path);

                                  // notificationProvider.Checklist(true);
                                  // print(notificationProvider.isChecklist);
                                  // CustomNavigator.pop(context);
                                },
                                bgColor: AppColors.primary,
                                textColor: AppColors.secondary,
                                dHeight: 40.h,
                                dWidth: 200.w,
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )
                        : Container()),

                CustomSpacers.height35
              ],
            );
          },
        ),
      ),
    );
  }

  _buildBottom() => Consumer<HomeProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Column(
              children: [
                Text(
                  "Choose the items from the following Checklists- ",
                  style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.w500),
                ),
                CustomSpacers.height30,
                TonsDropdown(
                    items: value.getTonsList,
                    hintText: "Tons",
                    validator: (v) {},
                    onChanged: (v) {
                      print(v);
                      value.getTonsModel(v);
                      setState(() {
                        _isModel = true;
                        subCatCat = v;
                      });
                    }),
                CustomSpacers.height40,
                _isModel
                    ? TonsModelDropdown(
                        items: value.getModelList,
                        hintText: "Model",
                        validator: (v) {},
                        onChanged: (v) {
                          setState(() {
                            modelID = v;
                          });
                        })
                    : Container(),
                CustomSpacers.height24
              ],
            ),
          );
        },
      );
}
