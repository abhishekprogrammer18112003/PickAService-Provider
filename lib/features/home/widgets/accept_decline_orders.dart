// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_icons.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/data/home_provider.dart';
import 'package:pick_a_service/features/home/data/notification_provider.dart';
import 'package:pick_a_service/features/home/models/accepted_models.dart';
import 'package:pick_a_service/location_service.dart';
import 'package:pick_a_service/route/app_pages.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:pick_a_service/ui/global%20widegts/custom_button_accept_widget.dart';
import 'package:provider/provider.dart';

class AcceptRejectOrdersWidget extends StatefulWidget {
  Map<String, dynamic> arguments;
  AcceptedOrdersModel data;
  AcceptRejectOrdersWidget(
      {super.key, required this.data, required this.arguments});

  @override
  State<AcceptRejectOrdersWidget> createState() =>
      _AcceptRejectOrdersWidgetState();
}

class _AcceptRejectOrdersWidgetState extends State<AcceptRejectOrdersWidget> {
  String? status;
  AcceptedOrdersModel? data;
  @override
  void initState() {
    super.initState();

    data = widget.data;
    print(data!.WorkStatus);
    if (data!.WorkStatus == "Accepted") {
      status = "START";
    }

    if (data!.WorkStatus == "Started") {
      status = "REACHED";
    }
    if (data!.WorkStatus == "Reached") {
      status = "CREATE CHECKLIST";
    }

      if (data!.WorkStatus ==  "Checklist Created" ) {
      status = "VIEW CHECKLIST";
    }
      if(data!.WorkStatus == "Invoice Created"){
        status = "OBSERVATION";
      }
 
  }

  LocationService locationService = LocationService();
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    return !notificationProvider.isLoading
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                      // print(notificationProvider.isChecklist);
                      // if (notificationProvider.isChecklist) {
                      //   CustomNavigator.pushTo(context, AppPages.invoice);
                      // } else if (notificationProvider.isStarted == false) {
                      //   locationService.startLocationService(false);
                      //   notificationProvider.Start(true);
                      // } else if (notificationProvider.isStarted &&
                      //     notificationProvider.isReached == false) {
                      //   locationService.startLocationService(true);
                      //   notificationProvider.Reached(true);
                      // } else if (notificationProvider.isStarted &&
                      //     notificationProvider.isReached) {
                      //   CustomNavigator.pushTo(context, AppPages.checklist);
                      // }
                      print(status);
                      if (status == "START") {
                        locationService.startLocationService(false);
                        notificationProvider
                            .acceptOrder(widget.data.ticketId, "Start" , context);
                            
                        setState(() {
                          status = "REACHED";
                        });
                      } else if (status == "REACHED") {
                        locationService.startLocationService(true);
                        notificationProvider.acceptOrder(
                            widget.data.ticketId, "Reached" , context);
                        setState(() {
                          status = "CREATE CHECKLIST";
                        });
                      } else if (status == "CREATE CHECKLIST") {
                        CustomNavigator.pushTo(context, AppPages.checklist,
                            arguments: data).then((v) async {
                          await homeProvider.getacceptedOrders();

                          if (widget.arguments["day"] == "This Week") {
                            setState(() {
                              data = homeProvider.acceptedThisWeekOrdersList[
                                  widget.arguments["ind"]];
                            });
                          } else if (widget.arguments["day"] == "Tomorrow") {
                            setState(() {
                              data = homeProvider.acceptedTomorrowOrdersList[
                                  widget.arguments["ind"]];
                            });
                          } else {
                            setState(() {
                              data = homeProvider.acceptedTodayOrdersList[
                                  widget.arguments["ind"]];
                            });
                          }
                        });
                      } else if (status == "VIEW CHECKLIST") {
                        CustomNavigator.pushTo(context, AppPages.viewChecklist,
                            arguments: data).then((v) async {
                          await homeProvider.getacceptedOrders();

                          if (widget.arguments["day"] == "This Week") {
                            setState(() {
                              data = homeProvider.acceptedThisWeekOrdersList[
                                  widget.arguments["ind"]];
                            });
                          } else if (widget.arguments["day"] == "Tomorrow") {
                            setState(() {
                              data = homeProvider.acceptedTomorrowOrdersList[
                                  widget.arguments["ind"]];
                            });
                          } else {
                            setState(() {
                              data = homeProvider.acceptedTodayOrdersList[
                                  widget.arguments["ind"]];
                            });
                          }
                        });
                      }
                    },
                    child: CustomAcceptButtonWidget(
                      text: status!,
                      height: 34.h,
                      width: status == "START"
                          ? 107.w
                          : status == "VIEW CHECKLIST" || status == "OBSERVATION"
                              ? 127.w
                              : 247.w,
                      radius: 7.r,
                      image: AppIcons.accept,
                      style: TextStyle(
                          fontSize: 10.w,
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondary),
                      color: Color.fromARGB(255, 0, 184, 10),
                    )

                    ),
                GestureDetector(
                    onTap: () async {
                      if (status == "START") {
                        await notificationProvider
                            .declineOrder(widget.data.ticketId , context);
                        Navigator.pop(context);
                      }

                      if (status == "VIEW CHECKLIST") {
                        CustomNavigator.pushTo(context, AppPages.invoice,
                            arguments: data).then((v) async {
                          await homeProvider.getacceptedOrders();

                          if (widget.arguments["day"] == "This Week") {
                            setState(() {
                              data = homeProvider.acceptedThisWeekOrdersList[
                                  widget.arguments["ind"]];
                            });
                          } else if (widget.arguments["day"] == "Tomorrow") {
                            setState(() {
                              data = homeProvider.acceptedTomorrowOrdersList[
                                  widget.arguments["ind"]];
                            });
                          } else {
                            setState(() {
                              data = homeProvider.acceptedTodayOrdersList[
                                  widget.arguments["ind"]];
                            });
                          }
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
                                color: Color.fromARGB(186, 255, 54, 165),
                              )
                            : status ==  "OBSERVATION"  ? CustomAcceptButtonWidget(
                                text: "COMPLETED",
                                height: 34.h,
                                width: 127.w,
                                radius: 7.r,
                                image: AppIcons.airconditioning,
                                style: TextStyle(
                                    fontSize: 10.w,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.secondary),
                                color: Color.fromARGB(185, 255, 54, 54),
                              ) :  Container())
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
