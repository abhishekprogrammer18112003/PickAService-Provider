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
import 'package:pick_a_service/features/ticket_details_provider.dart';
import 'package:pick_a_service/flutter_background_service_10min.dart';
import 'package:pick_a_service/flutter_background_service_15sec.dart';
import 'package:pick_a_service/location_service.dart';
import 'package:pick_a_service/route/app_pages.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:pick_a_service/ticket_details_model.dart';
import 'package:pick_a_service/ui/global%20widegts/custom_button_accept_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersScreen extends StatefulWidget {
  Map<String, dynamic> arguments;
  // AcceptedOrdersModel data;
  int ticketId;
  OrdersScreen({super.key, required this.ticketId, required this.arguments});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  TicketDetailsModel? data;

  String? status;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<TicketDetailsProvider>(context, listen: false)
          .getTicketData(context, widget.ticketId);
      final provider =
          Provider.of<TicketDetailsProvider>(context, listen: false);
      data = provider.TicketDetails[0];
      updateStatus(data);
    });
  }

  void updateStatus(TicketDetailsModel? d) {
    // print(d!.WorkStatus);
    // status = d!.WorkStatus;
    if (d!.WorkStatus == "Accepted") {
      status = AppLocalizations.of(context)!.start;
    }

    if (d.WorkStatus == "Started") {
      status = AppLocalizations.of(context)!.reached;
    }
    if (d.WorkStatus == "Reached") {
      status = AppLocalizations.of(context)!.createchecklist;
    }

    if (d.WorkStatus == "Checklist Created") {
      status = AppLocalizations.of(context)!.viewchecklist;
    }
    if (d.WorkStatus == "Invoice Created") {
      status = "PAID";
    }
    if (d.WorkStatus == "Observation") {
      status = AppLocalizations.of(context)!.completed;
    }
    if (d.WorkStatus == "Completed") {
      status = "DONE";
    }

    if (d.WorkStatus == "Paid") {
      status = AppLocalizations.of(context)!.observation;
    }
    setState(() {
      print("=======status======");
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
    final provider = Provider.of<TicketDetailsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.ticketdetails,
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
          await provider.getTicketData(context, widget.ticketId);
          data = provider.TicketDetails[0];

          setState(() {
            updateStatus(data);
          });
        },
        child: Consumer<TicketDetailsProvider>(
          builder: (context, value, child) {
            return !value.isNotificationLoading
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              AppLocalizations.of(context)!.customerdetails,
              style: TextStyle(
                fontSize: 20.w,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          CustomSpacers.height16,
          _buildNameMobileWidget(),
          CustomSpacers.height16,
          // _buildDescriptionWidget(),
          DescriptionWidget(description: data!.Descriptions),
          CustomSpacers.height16,
          _buildAdressWidget(),
          CustomSpacers.height24,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 44.w),
            // child: AcceptRejectOrdersWidget(data: data! , arguments: {"day": widget.arguments["day"], "ind": widget.arguments["ind"]},),
            child: widget.arguments["day"] ==
                    AppLocalizations.of(context)!.today.toLowerCase()
                ? _buildSendTrackingLink()
                : Container(),
          ),
          CustomSpacers.height10,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 44.w),
            // child: AcceptRejectOrdersWidget(data: data! , arguments: {"day": widget.arguments["day"], "ind": widget.arguments["ind"]},),
            child: widget.arguments["day"] ==
                    AppLocalizations.of(context)!.today.toLowerCase()
                ? _buildButtons()
                : Container(),
          ),
          CustomSpacers.height32,
        ],
      );

  _buildSendTrackingLink() {
    final p = Provider.of<HomeProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        p.sendTrack(context, data!.CustomerId, data!.ticketId);
      },
      child: Consumer<HomeProvider>(
        builder: (context, value, child) => !value.isTrack
            ? Center(
                child: CustomAcceptButtonWidget(
                  text: "send Tracking link",
                  height: 34.h,
                  width: 250.w,
                  radius: 7.r,
                  image: AppIcons.profileFaq,
                  style: TextStyle(
                      fontSize: 10.w,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary),
                  color: Color.fromARGB(255, 0, 184, 169),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

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
                Text(AppLocalizations.of(context)!.name,
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
                        EdgeInsets.symmetric(horizontal: 16, vertical: 15.h),
                    child: Text(
                      data!.customerName,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ),
                ),

                CustomSpacers.height12,

                Text(AppLocalizations.of(context)!.mobile,
                    style: TextStyle(
                      fontSize: 12.w,
                      fontWeight: FontWeight.w600,
                    )),
                CustomSpacers.height8,

                GestureDetector(
                  onTap: () async {
                    final Uri url =
                        Uri(scheme: 'tel', path: data!.customerPhone);
                    if (await canLaunchUrl(url)) {
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
                              offset:
                                  Offset(0, 2), // changes position of shadow
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
                                    data!.customerPhone,
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
                  Text(AppLocalizations.of(context)!.desc,
                      style: TextStyle(
                        fontSize: 12.w,
                        fontWeight: FontWeight.w600,
                      )),
                  CustomSpacers.height10,
                  Container(
                    // height: 80.h,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 9.h),
                      child: Text(
                        data!.Descriptions,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
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
                Text(AppLocalizations.of(context)!.address,
                    style: TextStyle(
                      fontSize: 12.w,
                      fontWeight: FontWeight.w600,
                    )),
                CustomSpacers.height10,
                Container(
                  // height: 60.h,
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
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 9.h),
                    child: Text(
                      data!.NameOfAddress,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
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
                        text: AppLocalizations.of(context)!.getdirection),
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
    final provider = Provider.of<TicketDetailsProvider>(context, listen: false);

    return !notificationProvider.isLoading
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: Column(
              children: [
                status == AppLocalizations.of(context)!.observation ||
                        status == "DONE" ||
                        status == AppLocalizations.of(context)!.completed ||
                        status == "PAID"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              CustomNavigator.pushTo(
                                      context, AppPages.viewChecklist,
                                      arguments: data)
                                  .then((v) async {
                                await provider.getTicketData(
                                    context, widget.ticketId);
                                data = provider.TicketDetails[0];

                                // if (widget.arguments["day"] == "This Week") {
                                //   setState(() {
                                //     data =
                                //         homeProvider.acceptedThisWeekOrdersList[
                                //             widget.arguments["ind"]];
                                //   });
                                // } else if (widget.arguments["day"] ==
                                //     "Tomorrow") {
                                //   setState(() {
                                //     data =
                                //         homeProvider.acceptedTomorrowOrdersList[
                                //             widget.arguments["ind"]];
                                //   });
                                // } else {
                                //   setState(() {
                                //     data = homeProvider.acceptedTodayOrdersList[
                                //         widget.arguments["ind"]];
                                //   });
                                // }
                                setState(() {
                                  print("updating status ");
                                  updateStatus(data);
                                });
                              });
                              ;
                            },
                            child: CustomAcceptButtonWidget(
                              text: AppLocalizations.of(context)!.viewchecklist,
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
                                      arguments: data)
                                  .then((v) async {
                                await provider.getTicketData(
                                    context, widget.ticketId);
                                data = provider.TicketDetails[0];

                                // if (widget.arguments["day"] == "This Week") {
                                //   setState(() {
                                //     data =
                                //         homeProvider.acceptedThisWeekOrdersList[
                                //             widget.arguments["ind"]];
                                //   });
                                // } else if (widget.arguments["day"] ==
                                //     "Tomorrow") {
                                //   setState(() {
                                //     data =
                                //         homeProvider.acceptedTomorrowOrdersList[
                                //             widget.arguments["ind"]];
                                //   });
                                // } else {
                                //   setState(() {
                                //     data = homeProvider.acceptedTodayOrdersList[
                                //         widget.arguments["ind"]];
                                //   });
                                // }
                                setState(() {
                                  print("updating status ");
                                  updateStatus(data);
                                });
                              });
                              ;
                            },
                            child: CustomAcceptButtonWidget(
                              text: AppLocalizations.of(context)!.viewinvoice,
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
                status == AppLocalizations.of(context)!.observation ||
                        status == AppLocalizations.of(context)!.start ||
                        status == AppLocalizations.of(context)!.reached ||
                        status ==
                            AppLocalizations.of(context)!.createchecklist ||
                        status == AppLocalizations.of(context)!.viewchecklist ||
                        status == AppLocalizations.of(context)!.completed
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                print(status);
                                if (status ==
                                    AppLocalizations.of(context)!.start) {
                                      // await stopBackgroundService();
                                      // await initializeService15secs();
                                  locationService.startLocationService(false);
                                  notificationProvider.acceptOrder(
                                      data!.ticketId, "Start", context);

                                  setState(() {
                                    status =
                                        AppLocalizations.of(context)!.reached;
                                  });
                                } else if (status ==
                                    AppLocalizations.of(context)!.reached) {
                                      // await stopBackgroundService();
                                      // await initializeService();
                                  locationService.startLocationService(true);
                                  notificationProvider.acceptOrder(
                                      data!.ticketId, "Reached", context);
                                  setState(() {
                                    status = AppLocalizations.of(context)!
                                        .createchecklist;
                                  });
                                } else if (status ==
                                    AppLocalizations.of(context)!
                                        .createchecklist) {
                                  CustomNavigator.pushTo(
                                          context, AppPages.checklist,
                                          arguments: data)
                                      .then((v) async {
                                    await provider.getTicketData(
                                        context, widget.ticketId);
                                    data = provider.TicketDetails[0];

                                    // if (widget.arguments["day"] ==
                                    //     "This Week") {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedThisWeekOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // } else if (widget.arguments["day"] ==
                                    //     "Tomorrow") {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedTomorrowOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // } else {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedTodayOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // }
                                    setState(() {
                                      print("updating status ");
                                      updateStatus(data);
                                    });
                                  });
                                } else if (status ==
                                    AppLocalizations.of(context)!
                                        .viewchecklist) {
                                  CustomNavigator.pushTo(
                                          context, AppPages.viewChecklist,
                                          arguments: data)
                                      .then((v) async {
                                    await provider.getTicketData(
                                        context, widget.ticketId);
                                    data = provider.TicketDetails[0];

                                    // if (widget.arguments["day"] ==
                                    //     "This Week") {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedThisWeekOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // } else if (widget.arguments["day"] ==
                                    //     "Tomorrow") {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedTomorrowOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // } else {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedTodayOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // }
                                    setState(() {
                                      updateStatus(data);
                                    });
                                  });
                                } else if (status ==
                                    AppLocalizations.of(context)!.observation) {
                                  await notificationProvider
                                      .acceptOrder(data!.ticketId,
                                          "Observation", context)
                                      .then((v) async {
                                    await provider.getTicketData(
                                        context, widget.ticketId);
                                    data = provider.TicketDetails[0];
                                    // if (widget.arguments["day"] ==
                                    //     "This Week") {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedThisWeekOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // } else if (widget.arguments["day"] ==
                                    //     "Tomorrow") {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedTomorrowOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // } else {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedTodayOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // }
                                    setState(() {
                                      updateStatus(data);
                                    });
                                  });
                                } else if (status ==
                                    AppLocalizations.of(context)!.completed) {
                                  await notificationProvider
                                      .acceptOrder(
                                          data!.ticketId, "Completed", context)
                                      .then((v) async {
                                    await provider.getTicketData(
                                        context, widget.ticketId);
                                    data = provider.TicketDetails[0];

                                    // if (widget.arguments["day"] ==
                                    //     "This Week") {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedThisWeekOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // } else if (widget.arguments["day"] ==
                                    //     "Tomorrow") {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedTomorrowOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // } else {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedTodayOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // }
                                    setState(() {
                                      updateStatus(data);
                                    });
                                  });
                                }
                              },
                              child: CustomAcceptButtonWidget(
                                text: status!,
                                height: 34.h,
                                width: status ==
                                        AppLocalizations.of(context)!.start
                                    ? 107.w
                                    : status ==
                                                AppLocalizations.of(context)!
                                                    .viewchecklist ||
                                            status ==
                                                AppLocalizations.of(context)!
                                                    .observation
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
                                if (status ==
                                    AppLocalizations.of(context)!.start) {
                                  await notificationProvider.declineOrder(
                                      data!.ticketId, context).then((v){
                                        Navigator.pop(context);
                                      });
                                  
                                }

                                if (status ==
                                    AppLocalizations.of(context)!
                                        .viewchecklist) {
                                  CustomNavigator.pushTo(
                                          context, AppPages.invoice,
                                          arguments: data)
                                      .then((v) async {
                                    await provider.getTicketData(
                                        context, widget.ticketId);
                                    data = provider.TicketDetails[0];

                                    // if (widget.arguments["day"] ==
                                    //     "This Week") {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedThisWeekOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // } else if (widget.arguments["day"] ==
                                    //     "Tomorrow") {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedTomorrowOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // } else {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedTodayOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // }
                                    setState(() {
                                      print("updating status ");
                                      updateStatus(data);
                                    });
                                  });
                                } else if (status ==
                                    AppLocalizations.of(context)!.observation) {
                                  await notificationProvider
                                      .acceptOrder(
                                          data!.ticketId, "Completed", context)
                                      .then((v) async {
                                    await provider.getTicketData(
                                        context, widget.ticketId);
                                    data = provider.TicketDetails[0];
                                    // if (widget.arguments["day"] ==
                                    //     "This Week") {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedThisWeekOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // } else if (widget.arguments["day"] ==
                                    //     "Tomorrow") {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedTomorrowOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // } else {
                                    //   setState(() {
                                    //     data = homeProvider
                                    //             .acceptedTodayOrdersList[
                                    //         widget.arguments["ind"]];
                                    //   });
                                    // }
                                    setState(() {
                                      updateStatus(data);
                                    });
                                  });
                                }
                              },
                              child: status ==
                                      AppLocalizations.of(context)!.start
                                  ? CustomAcceptButtonWidget(
                                      text:
                                          AppLocalizations.of(context)!.cancel,
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
                                  : status ==
                                          AppLocalizations.of(context)!
                                              .viewchecklist
                                      ? CustomAcceptButtonWidget(
                                          text: AppLocalizations.of(context)!
                                              .createinvoice,
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
                                      : status ==
                                              AppLocalizations.of(context)!
                                                  .observation
                                          ? CustomAcceptButtonWidget(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .completed,
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

class DescriptionWidget extends StatefulWidget {
  final String description;

  DescriptionWidget({required this.description});

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.desc,
                  style: TextStyle(
                    fontSize: 12.w,
                    fontWeight: FontWeight.w600,
                  )),
              CustomSpacers.height10,
              Container(
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
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 9.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.description,
                        maxLines: isExpanded ? null : 3,
                        overflow: isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Text(
                          isExpanded ? "See less" : "See more",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomSpacers.height12
            ],
          ),
        ),
      ),
    );
  }
}
