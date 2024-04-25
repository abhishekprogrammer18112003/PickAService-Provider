// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, unused_local_variable, must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:intl/intl.dart';
// import 'package:pick_a_service/core/constants/app_colors.dart';
// import 'package:pick_a_service/core/constants/app_icons.dart';
// import 'package:pick_a_service/core/helpers/network_helpers.dart';
// import 'package:pick_a_service/core/managers/app_manager.dart';
// import 'package:pick_a_service/core/utils/custom_spacers.dart';
// import 'package:pick_a_service/core/utils/screen_utils.dart';
// import 'package:pick_a_service/features/home/data/notification_provider.dart';
// import 'package:pick_a_service/features/service%20history/data/schedule_history_provider.dart';
// import 'package:pick_a_service/features/service%20history/models/schedule_history_model.dart';
// import 'package:pick_a_service/features/service%20history/widgets/pending_orders_widget.dart';
// import 'package:pick_a_service/notification_pending_orders_widget.dart';
// import 'package:pick_a_service/notification_service.dart';
// import 'package:pick_a_service/route/app_pages.dart';
// import 'package:pick_a_service/route/custom_navigator.dart';
// import 'package:pick_a_service/ui/global%20widegts/acceptrejectwidget.dart';
// import 'package:pick_a_service/ui/global%20widegts/custom_button_accept_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// class NotificationServiceScreen extends StatefulWidget {
//   int ticketId;
//   NotificationServiceScreen({super.key , required this.ticketId});

//   @override
//   State<NotificationServiceScreen> createState() => _NotificationServiceScreenState();
// }

// class _NotificationServiceScreenState extends State<NotificationServiceScreen> {
//   ScheduleHistoryModel? data;

//   String? status;

//   void updateStatus(ScheduleHistoryModel? d) {
//     if (d!.WorkStatus == "Accepted") {
//       status = "START";
//     }

//     if (d.WorkStatus == "Started") {
//       status = "REACHED";
//     }
//     if (d.WorkStatus == "Reached") {
//       status = "CREATE CHECKLIST";
//     }

//     if (d.WorkStatus == "Checklist Created") {
//       status = "VIEW CHECKLIST";
//     }
//     if (d.WorkStatus == "Invoice Created") {
//       status = "PAID";
//     }
//     if (d.WorkStatus == "Observation") {
//       status = "COMPLETED";
//     }
//     if (d.WorkStatus == "Completed") {
//       status = "DONE";
//     }

//     if (d.WorkStatus == "Paid") {
//       status = "OBSERVATION";
//     }
//     setState(() {
//       print(status);
//     });
//   }

//   String? formattedDate;
//   @override
//   void initState() {
//     super.initState();
//     // print(widget.arguments);

//     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//     //   await Provider.of<NotificationServiceProvider>(context, listen: false)
//     //       .getNotificationData(context , widget.ticketId);
//     // });
//   }

//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _mobileController = TextEditingController();

//   TextEditingController _descriptionController = TextEditingController();

//   TextEditingController _addressController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<NotificationServiceProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text("Ticket Details",
//             style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.w600)),
//         leading: GestureDetector(
//             onTap: () => CustomNavigator.pop(context),
//             child: Image.asset(AppIcons.backbutton)),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
//             child: Image.asset(
//               AppIcons.app_logo,
//               color: AppColors.primary,
//               height: 43.h,
//               width: 56.w,
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//           child: !provider.isNotificationLoading ?  Column(
//         // mainAxisAlignment: MainAxisAlignment.start,/
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CustomSpacers.height10,
//           NotificationPendingOrdersWidget(
//               data: provider.notificationTicketDetails[0]),
//           CustomSpacers.height24,
//           _buildWidget(),
//         ],
//       ) : Center(child: CircularProgressIndicator(),)),
//     );
//   }

//   _buildWidget() => Consumer<NotificationServiceProvider>(
//         builder: (context, value, child) => Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Customer Details",
//                   style: TextStyle(
//                     fontSize: 20.w,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//             CustomSpacers.height16,
//             _buildNameMobileWidget(),
//             CustomSpacers.height16,
//             _buildDescriptionWidget(),
//             CustomSpacers.height16,
//             _buildAdressWidget(),
//             CustomSpacers.height24,
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 44.w),
//               child: AcceptRejectWidget(
//                   id: value.notificationTicketDetails[0].ticketId),
//             ),
//             CustomSpacers.height32,
//           ],
//         ),
//       );
//   _buildNameMobileWidget() => Consumer<NotificationServiceProvider>(
//         builder: (context, value, child) => Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Container(
//             width: 343.w,
//             decoration: BoxDecoration(
//               color: AppColors.secondary,
//               borderRadius: BorderRadius.circular(10.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color.fromARGB(255, 218, 218, 218),
//                   spreadRadius: 3,
//                   blurRadius: 3,
//                   offset: Offset(0, 5), // changes position of shadow
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Name",
//                       style: TextStyle(
//                         fontSize: 12.w,
//                         fontWeight: FontWeight.w600,
//                       )),

//                   CustomSpacers.height8,
//                   //name
//                   Container(
//                     height: 50.h,
//                     width: 295.w,
//                     decoration: BoxDecoration(
//                       color: AppColors.secondary,
//                       borderRadius: BorderRadius.circular(5.r),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color.fromARGB(122, 200, 200, 200)
//                               .withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 1,
//                           offset: Offset(0, 2), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             value.notificationTicketDetails[0].customerName,
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey),
//                           )),
//                     ),
//                   ),

//                   CustomSpacers.height12,

//                   Text("Mobile Number",
//                       style: TextStyle(
//                         fontSize: 12.w,
//                         fontWeight: FontWeight.w600,
//                       )),
//                   CustomSpacers.height8,

//                   GestureDetector(
//                     onTap: () async {
//                       final Uri url = Uri(
//                           scheme: 'tel',
//                           path:
//                               value.notificationTicketDetails[0].customerPhone);
//                       if (await canLaunchUrl(url)) {
//                         await launchUrl(url);
//                       }
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 50.h,
//                           width: 295.w,
//                           decoration: BoxDecoration(
//                             color: AppColors.secondary,
//                             borderRadius: BorderRadius.circular(5.r),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Color.fromARGB(122, 200, 200, 200)
//                                     .withOpacity(0.5),
//                                 spreadRadius: 2,
//                                 blurRadius: 1,
//                                 offset:
//                                     Offset(0, 2), // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       value.notificationTicketDetails[0]
//                                           .customerPhone,
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.grey),
//                                     )),
//                                 Align(
//                                   alignment: Alignment.centerRight,
//                                   child: Container(
//                                     height: 25.h,
//                                     width: 25.w,
//                                     decoration: BoxDecoration(
//                                         color: AppColors.black,
//                                         borderRadius:
//                                             BorderRadius.circular(5.r)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(5.0),
//                                       child: Image.asset(
//                                         AppIcons.mobile,
//                                         height: 20.h,
//                                         width: 15.w,
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   CustomSpacers.height12
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );

//   _buildDescriptionWidget() => Consumer<NotificationServiceProvider>(
//         builder: (context, value, child) => Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Container(
//               // height: 109.h,
//               width: 343.w,
//               decoration: BoxDecoration(
//                 color: AppColors.secondary,
//                 borderRadius: BorderRadius.circular(10.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: const Color.fromARGB(255, 218, 218, 218),
//                     spreadRadius: 3,
//                     blurRadius: 3,
//                     offset: Offset(0, 5), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Description",
//                         style: TextStyle(
//                           fontSize: 12.w,
//                           fontWeight: FontWeight.w600,
//                         )),
//                     CustomSpacers.height10,
//                     Container(
//                       height: 80.h,
//                       width: 295.w,
//                       decoration: BoxDecoration(
//                         color: AppColors.secondary,
//                         borderRadius: BorderRadius.circular(5.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color.fromARGB(122, 200, 200, 200)
//                                 .withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 1,
//                             offset: Offset(0, 2), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 8),
//                         child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               value.notificationTicketDetails[0].Descriptions,
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.grey),
//                             )),
//                       ),
//                     ),
//                     CustomSpacers.height12
//                   ],
//                 ),
//               )),
//         ),
//       );

//   _buildAdressWidget() => Consumer<NotificationServiceProvider>(
//         builder: (context, value, child) => Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Container(
//             width: 343.w,
//             decoration: BoxDecoration(
//               color: AppColors.secondary,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color.fromARGB(255, 218, 218, 218),
//                   spreadRadius: 3,
//                   blurRadius: 3,
//                   offset: Offset(0, 5), // changes position of shadow
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Address",
//                       style: TextStyle(
//                         fontSize: 12.w,
//                         fontWeight: FontWeight.w600,
//                       )),
//                   CustomSpacers.height10,
//                   Container(
//                     height: 60.h,
//                     width: 295.w,
//                     decoration: BoxDecoration(
//                       color: AppColors.secondary,
//                       borderRadius: BorderRadius.circular(5.r),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color.fromARGB(122, 200, 200, 200)
//                               .withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 1,
//                           offset: Offset(0, 2), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16.0, vertical: 8),
//                       child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             value.notificationTicketDetails[0].NameOfAddress,
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey),
//                           )),
//                     ),
//                   ),
//                   CustomSpacers.height16,
//                   GestureDetector(
//                     onTap: () {
//                       // CustomNavigator.pushTo(context, AppPages.direction , arguments: widget.arguments);

//                       openMap(value.notificationTicketDetails[0].Latitude,
//                           value.notificationTicketDetails[0].Longitude);
//                     },
//                     child: Center(
//                       child: CustomAcceptButtonWidget(
//                           height: 34.h,
//                           width: 131.w,
//                           image: AppIcons.direction,
//                           color: Color.fromARGB(255, 0, 98, 255),
//                           radius: 7.r,
//                           style: TextStyle(
//                               fontSize: 10.w,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.secondary),
//                           text: "Get Direction"),
//                     ),
//                   ),
//                   CustomSpacers.height12
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );

//   void openMap(double latitude, double longitude) async {
//     String googleMapsUrl =
//         'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

//     NetworkHelpers.launchUrl(url: googleMapsUrl, errorCallback: () {});
//   }
// }
