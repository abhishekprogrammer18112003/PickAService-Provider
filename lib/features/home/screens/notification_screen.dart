// ignore_for_file: prefer_const_constructors, unnecessary_import, await_only_futures

import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_icons.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/data/notification_provider.dart';
import 'package:pick_a_service/features/home/widgets/notification_card_widget.dart';
import 'package:pick_a_service/route/app_pages.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<NotificationProvider>(context, listen: false)
          .getNotificationDataWithoutTimer(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await Provider.of<NotificationProvider>(context, listen: false)
              .getNotificationDataWithoutTimer(context);
        });
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Notifications",
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
          child: SizedBox(
            child: Column(
              children: [
                CustomSpacers.height10,
                _buildCards(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildCards() {
    final provider = Provider.of<NotificationProvider>(context);
    return SizedBox(
        height: 720.h,
        child: !provider.isLoading
            ? provider.notification.isNotEmpty
                ? ListView.builder(
                    itemCount: provider.notification.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: NotificationCardWidget(
                            data: provider.notification[index]),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No new Notification !",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey),
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}









 // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(206.h), // Custom height
      //   child: AppBar(
      //     backgroundColor: AppColors.secondary,
      //     automaticallyImplyLeading: false,
      //     flexibleSpace: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(top: 74, left: 16, right: 16),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               GestureDetector(
      //                   onTap: () => CustomNavigator.pop(context),
      //                   child: Image.asset(AppIcons.backbutton)),
      //               Image.asset(
      //                 AppIcons.app_logo,
      //                 color: AppColors.primary,
      //                 height: 43.h,
      //                 width: 56.w,
      //               ),

      //             ],
      //           ),
      //         ),
      //         CustomSpacers.height36,
      //         Divider(height: 2, thickness: 2),
      //         Padding(
      //           padding:
      //               const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
      //           child: Text("Notifications",
      //               style:
      //                   TextStyle(fontSize: 20.h, fontWeight: FontWeight.w600)),
      //         ),
      //         Divider(
      //           height: 2,
      //           thickness: 2,
      //         )
      //       ],
      //     ),
      //   ),
      // ),




// child: FutureBuilder<List<NotificationModel>>(
        //     future: Provider.of<NotificationProvider>(context , listen: false).getNotificationData(context),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(child: CircularProgressIndicator());
        //       } else if (snapshot.hasError) {
        //         return Center(child: Text('Error: ${snapshot.error}'));
        //       } else {
        //          final dataProvider = Provider.of<NotificationProvider>(context);
        //         return dataProvider.notification.isNotEmpty ?  ListView.builder(
        //             itemCount: dataProvider.notification.length,
        //             itemBuilder: (BuildContext context, int index) {
        //               return Padding(
        //                 padding: const EdgeInsets.only(bottom: 16.0),
        //                 child: NotificationCardWidget(
        //                     data: dataProvider.notification[index]),
        //               );
        //             }) : Center(child:
        //             Text("No Notification !"),);
        //       }
        //     }),

//         child: Consumer<NotificationProvider>(
//           builder: (context, value, child) {

//             return  StreamProvider<List<NotificationModel>>.value(
//               value: value.stream,
// initialData: [],
//               child: ListWidget(),
//             );

//           },
//         ),);

        // child: StreamBuilder<List<NotificationModel>>(
        //   stream: Provider.of<NotificationProvider>(context).stream,
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasError) {
        //       return Center(child: Text('Error: ${snapshot.error}'));
        //     } else {
        //       final data = snapshot.data!;
        //       if (data.isEmpty) {
        //         return Center(
        //           child: Text(
        //             "No notifications available.",
        //             style: TextStyle(
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.w500,
        //                 color: AppColors.grey),
        //           ),
        //         );
        //       } else {
        //         return ListView.builder(
        //           itemCount: data.length,
        //           itemBuilder: (context, index) {
        //             return Padding(
        //               padding: const EdgeInsets.symmetric(vertical: 8.0),
        //               child: NotificationCardWidget(data: data[index]),
        //             );
        //           },
        //         );
        //       }
        //     }
        //   },
        // )