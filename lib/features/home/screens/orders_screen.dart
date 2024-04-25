// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:get/get.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_icons.dart';
import 'package:pick_a_service/core/helpers/network_helpers.dart';
import 'package:pick_a_service/core/utils/custom_spacers.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/data/home_provider.dart';
import 'package:pick_a_service/features/home/data/notification_provider.dart';
import 'package:pick_a_service/features/home/models/accepted_models.dart';
import 'package:pick_a_service/features/home/widgets/accept_decline_orders.dart';
import 'package:pick_a_service/features/home/widgets/orders_widget.dart';
import 'package:pick_a_service/location_service.dart';
import 'package:pick_a_service/route/app_pages.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:pick_a_service/ui/global%20widegts/custom_button_accept_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersScreen extends StatefulWidget {
  Map<String, dynamic> arguments;
  AcceptedOrdersModel data;
  OrdersScreen({super.key, required this.arguments, required this.data});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  AcceptedOrdersModel? data;

  String? status;
  @override
  void initState() {
    super.initState();

    data = widget.data;
    updateStatus(data);
  }

  void updateStatus(AcceptedOrdersModel? d) {
    // print(d!.WorkStatus);
    // status = d!.WorkStatus;
    if (d!.WorkStatus == "Accepted") {
      status = "START";
    }

    if (d.WorkStatus == "Started") {
      status = "REACHED";
    }
    if (d.WorkStatus == "Reached") {
      status = "CREATE CHECKLIST";
    }

    if (d.WorkStatus == "Checklist Created") {
      status = "VIEW CHECKLIST";
    }
    if (d.WorkStatus == "Invoice Created") {
      status = "PAID";
    }
    if (d.WorkStatus == "Observation") {
      status = "COMPLETED";
    }
    if (d.WorkStatus == "Completed") {
      status = "DONE";
    }

    if (d.WorkStatus == "Paid") {
      status = "OBSERVATION";
    }
    setState(() {
      print(status);
    });
  }

  LocationService locationService = LocationService();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Ticket Details",
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
      body: RefreshIndicator(
        onRefresh: () async {
          await homeProvider.getacceptedOrders();

          if (widget.arguments["day"] == "This Week") {
            setState(() {
              data = homeProvider
                  .acceptedThisWeekOrdersList[widget.arguments["ind"]];
            });
          } else if (widget.arguments["day"] == "Tomorrow") {
            setState(() {
              data = homeProvider
                  .acceptedTomorrowOrdersList[widget.arguments["ind"]];
            });
          } else {
            setState(() {
              data =
                  homeProvider.acceptedTodayOrdersList[widget.arguments["ind"]];
            });
          }

          setState(() {
            updateStatus(data);
          });
        },
        child: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return !value.isOrdersLoading
                ? SingleChildScrollView(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomSpacers.height10,
                      OrdersWidget(data: data!),
                      CustomSpacers.height24,
                      _buildWidget(),
                    ],
                  ))
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }

  _buildWidget() => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Customer Details",
                style: TextStyle(
                  fontSize: 20.w,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          CustomSpacers.height16,
          _buildNameMobileWidget(),
          CustomSpacers.height16,
          _buildDescriptionWidget(),
          CustomSpacers.height16,
          _buildAdressWidget(),
          CustomSpacers.height24,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 44.w),
            // child: AcceptRejectOrdersWidget(data: data! , arguments: {"day": widget.arguments["day"], "ind": widget.arguments["ind"]},),
            child: widget.arguments["day"] == "Today"
                ? _buildButtons()
                : Container(),
          ),
          CustomSpacers.height32,
        ],
      );
  _buildNameMobileWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 343.w,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 218, 218, 218),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name",
                    style: TextStyle(
                      fontSize: 12.w,
                      fontWeight: FontWeight.w600,
                    )),

                CustomSpacers.height8,
                //name
                Container(
                  height: 50.h,
                  width: 295.w,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(5.r),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(122, 200, 200, 200).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data!.Fullname,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        )),
                  ),
                ),

                CustomSpacers.height12,

                Text("Mobile Number",
                    style: TextStyle(
                      fontSize: 12.w,
                      fontWeight: FontWeight.w600,
                    )),
                CustomSpacers.height8,

                GestureDetector(
                  onTap: () async{
                    final Uri url = Uri(scheme: 'tel' , path: data!.PhoneNo);
                      if(await canLaunchUrl(url)){
                        await launchUrl(url);
                      } 
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                  height: 50.h,

                        width: 295.w,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(5.r),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(122, 200, 200, 200)
                                  .withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    data!.PhoneNo,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  )),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 25.h,
                                  width: 25.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.black,
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      AppIcons.mobile,
                                      height: 20.h,
                                      width: 15.w,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                CustomSpacers.height12
              ],
            ),
          ),
        ),
      );

  _buildDescriptionWidget() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
            // height: 109.h,
            width: 343.w,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 218, 218, 218),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description",
                      style: TextStyle(
                        fontSize: 12.w,
                        fontWeight: FontWeight.w600,
                      )),
                  CustomSpacers.height10,
                  Container(
                    height: 80.h,
                    width: 295.w,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(5.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(122, 200, 200, 200)
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            data!.Descriptions,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          )),
                    ),
                  ),
                  CustomSpacers.height12
                ],
              ),
            )),
      );

  _buildAdressWidget() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          width: 343.w,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 218, 218, 218),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Address",
                    style: TextStyle(
                      fontSize: 12.w,
                      fontWeight: FontWeight.w600,
                    )),
                CustomSpacers.height10,
                Container(
                  height: 60.h,
                  width: 295.w,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(5.r),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(122, 200, 200, 200).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data!.NameOfAddress,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        )),
                  ),
                ),
                CustomSpacers.height16,
                GestureDetector(
                  onTap: () {
                    // CustomNavigator.pushTo(context, AppPages.direction , arguments: widget.arguments);

                    openMap(data!.Latitude, data!.Longitude);
                  },
                  child: Center(
                    child: CustomAcceptButtonWidget(
                        height: 34.h,
                        width: 131.w,
                        image: AppIcons.direction,
                        color: Color.fromARGB(255, 0, 98, 255),
                        radius: 7.r,
                        style: TextStyle(
                            fontSize: 10.w,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondary),
                        text: "Get Direction"),
                  ),
                ),
                CustomSpacers.height12
              ],
            ),
          ),
        ),
      );

  _buildButtons() {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    return !notificationProvider.isLoading
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: Column(
              children: [
                status == "OBSERVATION" ||
                        status == "DONE" ||
                        status == "COMPLETED" ||
                        status == "PAID" 
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              CustomNavigator.pushTo(
                                  context, AppPages.viewChecklist,
                                  arguments: data).then((v) async {
                                    await homeProvider.getacceptedOrders();

                                    if (widget.arguments["day"] ==
                                        "This Week") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedThisWeekOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else if (widget.arguments["day"] ==
                                        "Tomorrow") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTomorrowOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTodayOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    }
                                    setState(() {
                                      print("updating status ");
                                      updateStatus(data);
                                    });
                                  });;
                            },
                            child: CustomAcceptButtonWidget(
                              text: "VIEW CHECKLIST",
                              height: 34.h,
                              width: 120.w,
                              radius: 7.r,
                              image: AppIcons.profileFaq,
                              style: TextStyle(
                                  fontSize: 10.w,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondary),
                              color: Color.fromARGB(255, 52, 0, 184),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              CustomNavigator.pushTo(
                                  context, AppPages.viewInvoice,
                                  arguments: data).then((v) async {
                                    await homeProvider.getacceptedOrders();

                                    if (widget.arguments["day"] ==
                                        "This Week") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedThisWeekOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else if (widget.arguments["day"] ==
                                        "Tomorrow") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTomorrowOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTodayOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    }
                                    setState(() {
                                      print("updating status ");
                                      updateStatus(data);
                                    });
                                  });;
                            },
                            child:  CustomAcceptButtonWidget(
                              text: "VIEW INVOICE",
                              height: 34.h,
                              width: 120.w,
                              radius: 7.r,
                              image: AppIcons.profileabout,
                              style: TextStyle(
                                  fontSize: 10.w,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondary),
                              color: Color.fromARGB(255, 166, 184, 0),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                CustomSpacers.height16,
                status == "COMPLETED" ||
                        status == "OBSERVATION" || status == "START" || status == "REACHED" 

                        || status == "CREATE CHECKLIST" || status == "VIEW CHECKLIST" || status == "COMPLETED"
                       
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                print(status);
                                if (status == "START") {
                                  locationService.startLocationService(false);
                                  notificationProvider.acceptOrder(
                                      widget.data.ticketId, "Start");

                                  setState(() {
                                    status = "REACHED";
                                  });
                                } else if (status == "REACHED") {
                                  locationService.startLocationService(true);
                                  notificationProvider.acceptOrder(
                                      widget.data.ticketId, "Reached");
                                  setState(() {
                                    status = "CREATE CHECKLIST";
                                  });
                                } else if (status == "CREATE CHECKLIST") {
                                  CustomNavigator.pushTo(
                                          context, AppPages.checklist,
                                          arguments: data)
                                      .then((v) async {
                                    await homeProvider.getacceptedOrders();

                                    if (widget.arguments["day"] ==
                                        "This Week") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedThisWeekOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else if (widget.arguments["day"] ==
                                        "Tomorrow") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTomorrowOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTodayOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    }
                                    setState(() {
                                      print("updating status ");
                                      updateStatus(data);
                                    });
                                  });
                                } else if (status == "VIEW CHECKLIST") {
                                  CustomNavigator.pushTo(
                                          context, AppPages.viewChecklist,
                                          arguments: data)
                                      .then((v) async {
                                    await homeProvider.getacceptedOrders();

                                    if (widget.arguments["day"] ==
                                        "This Week") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedThisWeekOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else if (widget.arguments["day"] ==
                                        "Tomorrow") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTomorrowOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTodayOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    }
                                    setState(() {
                                      updateStatus(data);
                                    });
                                  });
                                } else if (status == "OBSERVATION") {
                                  await notificationProvider
                                      .acceptOrder(
                                          data!.ticketId, "Observation")
                                      .then((v) async {
                                    await homeProvider.getacceptedOrders();

                                    if (widget.arguments["day"] ==
                                        "This Week") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedThisWeekOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else if (widget.arguments["day"] ==
                                        "Tomorrow") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTomorrowOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTodayOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    }
                                    setState(() {
                                      updateStatus(data);
                                    });
                                  });
                                } else if (status == "COMPLETED") {
                                  await notificationProvider
                                      .acceptOrder(data!.ticketId, "Completed")
                                      .then((v) async {
                                    await homeProvider.getacceptedOrders();

                                    if (widget.arguments["day"] ==
                                        "This Week") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedThisWeekOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else if (widget.arguments["day"] ==
                                        "Tomorrow") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTomorrowOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTodayOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    }
                                    setState(() {
                                      updateStatus(data);
                                    });
                                  });
                                }
                              },
                              child: CustomAcceptButtonWidget(
                                text: status!,
                                height: 34.h,
                                width: status == "START"
                                    ? 107.w
                                    : status == "VIEW CHECKLIST" ||
                                            status == "OBSERVATION"
                                        ? 127.w
                                        : 247.w,
                                radius: 7.r,
                                image: AppIcons.accept,
                                style: TextStyle(
                                    fontSize: 10.w,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.secondary),
                                color: Color.fromARGB(255, 0, 184, 10),
                              )),
                          GestureDetector(
                              onTap: () async {
                                if (status == "START") {
                                  await notificationProvider
                                      .declineOrder(widget.data.ticketId);
                                  Navigator.pop(context);
                                }

                                if (status == "VIEW CHECKLIST") {
                                  CustomNavigator.pushTo(
                                          context, AppPages.invoice,
                                          arguments: data)
                                      .then((v) async {
                                    await homeProvider.getacceptedOrders();

                                    if (widget.arguments["day"] ==
                                        "This Week") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedThisWeekOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else if (widget.arguments["day"] ==
                                        "Tomorrow") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTomorrowOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTodayOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    }
                                    setState(() {
                                      print("updating status ");
                                      updateStatus(data);
                                    });
                                  });
                                }




                                else if (status == "OBSERVATION") {
                                  await notificationProvider
                                      .acceptOrder(
                                          data!.ticketId, "Completed")
                                      .then((v) async {
                                    await homeProvider.getacceptedOrders();

                                    if (widget.arguments["day"] ==
                                        "This Week") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedThisWeekOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else if (widget.arguments["day"] ==
                                        "Tomorrow") {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTomorrowOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    } else {
                                      setState(() {
                                        data = homeProvider
                                                .acceptedTodayOrdersList[
                                            widget.arguments["ind"]];
                                      });
                                    }
                                    setState(() {
                                      updateStatus(data);
                                    });
                                  });
                                }
                              },
                              child: status == "START"
                                  ? CustomAcceptButtonWidget(
                                      text: "CANCEL",
                                      height: 34.h,
                                      width: 107.w,
                                      radius: 7.r,
                                      image: AppIcons.decline,
                                      style: TextStyle(
                                          fontSize: 10.w,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.secondary),
                                      color: Color.fromARGB(255, 248, 38, 51),
                                    )
                                  : status == "VIEW CHECKLIST"
                                      ? CustomAcceptButtonWidget(
                                          text: "CREATE INVOICE",
                                          height: 34.h,
                                          width: 127.w,
                                          radius: 7.r,
                                          image: AppIcons.airconditioning,
                                          style: TextStyle(
                                              fontSize: 10.w,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.secondary),
                                          color:
                                              Color.fromARGB(186, 255, 54, 165),
                                        )
                                      : status == "OBSERVATION"
                                          ? CustomAcceptButtonWidget(
                                              text: "COMPLETED",
                                              height: 34.h,
                                              width: 127.w,
                                              radius: 7.r,
                                              image: AppIcons.airconditioning,
                                              style: TextStyle(
                                                  fontSize: 10.w,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.secondary),
                                              color: Color.fromARGB(
                                                  185, 255, 54, 54),
                                            )
                                          : Container())
                        ],
                      )
                    : Container(),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  void openMap(double latitude, double longitude) async {
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    NetworkHelpers.launchUrl(url: googleMapsUrl, errorCallback: () {});
  }
}
