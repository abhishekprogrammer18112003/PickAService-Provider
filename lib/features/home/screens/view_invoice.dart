// ignore_for_file: prefer_interpolation_to_compose_strings, unused_import, prefer_final_fields, must_be_immutable

import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/constants/app_data.dart';
import 'package:pick_a_service/core/loaded_widget.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/data/home_provider.dart';
import 'package:pick_a_service/features/home/models/accepted_models.dart';
import 'package:pick_a_service/features/home/models/invoice_model.dart';
import 'package:pick_a_service/features/home/widgets/orders_widget.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:pick_a_service/ui/molecules/custom_autocomplete_text_field.dart';
import 'package:pick_a_service/ui/molecules/custom_button.dart';
import 'package:pick_a_service/ui/molecules/custom_drop_down.dart';
import 'package:pick_a_service/ui/molecules/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class ViewInvoiceScreen extends StatefulWidget {
  AcceptedOrdersModel arguments;
  ViewInvoiceScreen({super.key, required this.arguments});

  @override
  State<ViewInvoiceScreen> createState() => _ViewInvoiceScreenState();
}

class _ViewInvoiceScreenState extends State<ViewInvoiceScreen> {
  TextEditingController _invoiceController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  List<Map<String, dynamic>> list = [];
  List<InvoiceModel> data = [];
  int totalMoney = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeProvider>(context, listen: false)
          .viewInvoice(widget.arguments.invoiceId, context);
    });


    print(widget.arguments.WorkStatus);
  }

  String mop = "";

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        //   await Provider.of<HomeProvider>(context, listen: false)
        //       .viewInvoice(widget.arguments.invoiceId, context);
        // });
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 246, 251),
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 126, 217, 245),
          backgroundColor: Color.fromARGB(255, 244, 246, 251),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Invoice",
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
          child: Consumer<HomeProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  CustomSpacers.height10,
                  // _buildSearch(),
                  // CustomSpacers.height20,

                  OrdersWidget(data: widget.arguments),

                  // CustomSpacers.height20,
                  _buidPrices(),
                  CustomSpacers.height10,
                  // !value.isGeneratingInvoice
                  //     ? CustomButton(
                  //         strButtonText: "Generate Invoice",
                  //         buttonAction: () {

                  //           value.createInvoice(
                  //               52, widget.arguments.ticketId, list , context);
                  //         },
                  //         bgColor: AppColors.primary,
                  //         textColor: AppColors.secondary,
                  //         dHeight: 40.h,
                  //         dWidth: 220.w,
                  //       )
                  //     : Center(
                  //         child: CircularProgressIndicator(),
                  //       ),
                  CustomSpacers.height52,
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _buidPrices() => Consumer<HomeProvider>(
        builder: (context, value, child) {
          return !value.isGettingInvoice? Padding(
            padding: const EdgeInsets.all(14.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price",
                          style: TextStyle(
                              fontSize: 24.h, fontWeight: FontWeight.w600)),
                      Text(
                          value.viewInvoiceData["total_amount"].toString() +
                              " KD",
                          style: TextStyle(
                              fontSize: 22.h, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  CustomSpacers.height20,
                  
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              value.viewInvoiceData["invoiceItems"].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      value.viewInvoiceData["invoiceItems"]
                                          [index]["title"],
                                      style: TextStyle(
                                          fontSize: 14.h,
                                          fontWeight: FontWeight.w700)),
                                  CustomSpacers.height4,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          value.viewInvoiceData["invoiceItems"]
                                                      [index]["price"]
                                                  .toString() +
                                              " KD",
                                          style: TextStyle(
                                              fontSize: 14.h,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  CustomSpacers.height8,
                                  Divider()
                                ],
                              ),
                            );
                          },
                        ),
                      
                  CustomSpacers.height15,
                  widget.arguments.WorkStatus == "Paid" ||
                          widget.arguments.WorkStatus == "Observation" ||
                          widget.arguments.WorkStatus == "Completed" ? Container():
                       _buildBottom()
                      
                ],
              ),
            ),
          ) :  Center(
                          child: CircularProgressIndicator(),
                        );
        },
      );

  _buildBottom() {
    print(widget.arguments.WorkStatus);
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.height20,
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
              "Invoice No. - ",
              style: TextStyle(
                fontSize: 16.h,
                fontWeight: FontWeight.w500,
              ),
            ),
            CustomTextField(
              controller: _invoiceController,
              hint: "Enter Invoice No.",
            ),
            CustomSpacers.height20,
            Text(
              "Invoice Amount - ",
              style: TextStyle(
                fontSize: 16.h,
                fontWeight: FontWeight.w500,
              ),
            ),
            CustomTextField(
              controller: _amountController,
              hint: "Enter amount",
            ),
            CustomSpacers.height36,
            Center(
                child: !value!.isPayment
                    ? CustomButton(
                        strButtonText: "Save",
                        buttonAction: () {

                          // if(_amountController.text == value.viewInvoiceData["total_amount"].toString()){
                            value.offliinePayment(
                              mop,
                              _invoiceController.text,
                              _amountController.text,
                              widget.arguments.invoiceId,
                              widget.arguments.ticketId,
                              value.viewInvoiceData,
                              context);
                          // }
                          // else{
                            // OverlayManager.showToast(type: ToastType.Error, msg: "Enter the correct amount!");
                          // }
                          
                        },
                        dWidth: 150.w,
                        dCornerRadius: 20.r,
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ))
          ],
        );
      },
    );
  }
}
