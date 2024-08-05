// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_icons.dart';
import 'package:pick_a_service/core/utils/custom_spacers.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/data/home_provider.dart';
import 'package:pick_a_service/features/home/data/notification_provider.dart';
import 'package:pick_a_service/features/home/screens/notification_screen.dart';
import 'package:pick_a_service/features/service%20history/data/schedule_history_provider.dart';
import 'package:pick_a_service/features/service%20history/screens/completed.dart';
import 'package:pick_a_service/features/service%20history/screens/decline.dart';
import 'package:pick_a_service/features/service%20history/screens/upcoming.dart';
import 'package:pick_a_service/route/app_pages.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServiceHistoryScreen extends StatefulWidget {
  const ServiceHistoryScreen({super.key});

  @override
  State<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<ScheduleHistoryProvider>(context, listen: false)
          .getUpcomingTicketsData(context);
     await Provider.of<ScheduleHistoryProvider>(context, listen: false)
          .completeTask("Completed"); 

      await Provider.of<ScheduleHistoryProvider>(context, listen: false)
          .declinedTask(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    final notiProvider = Provider.of<NotificationProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(126.h), // Custom height
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.secondary,
            elevation: 0,
            bottom: TabBar(
              indicatorWeight: 5,
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle:
                  TextStyle(fontSize: 12.h, fontWeight: FontWeight.w900),
              labelColor: AppColors.primary,
              unselectedLabelColor: const Color.fromARGB(205, 0, 0, 0),
              unselectedLabelStyle:
                  TextStyle(fontSize: 12.h, fontWeight: FontWeight.w500),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppIcons.upcoming,
                        height: 17.h,
                        width: 15.w,
                      ),
                      CustomSpacers.width10,
                      Text(AppLocalizations.of(context)!.upcoming)
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppIcons.completed,
                        height: 17.h,
                        width: 15.w,
                      ),
                      CustomSpacers.width10,
                      Text(AppLocalizations.of(context)!.completed)
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   AppIcons.decline,
                      //   height: 17.h,
                      //   width: 15.w,
                      // ),
                      Icon(Icons.design_services_outlined),
                      CustomSpacers.width10,
                      Text(AppLocalizations.of(context)!.decline.toUpperCase())
                    ],
                  ),
                )
              ],
            ),
            flexibleSpace: Padding(
              padding: EdgeInsets.only(top: 34, left: 16, right: 16),
              child: Container(
                  // Custom height
                  //  demonstration
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () =>
                          CustomNavigator.pushReplace(context, AppPages.navbar),
                      child: Image.asset(
                        AppIcons.backbutton,
                        height: 45.h,
                        width: 45.w,
                      )),
                  Image.asset(
                    AppIcons.app_logo,
                    color: AppColors.primary,
                    height: 43.h,
                    width: 56.w,
                  ),
                  GestureDetector(
                      onTap: () {
                        _navigateToNotification(context);
                        notiProvider.notificationBtnCicked();
                      },
                      child: notiProvider.isNotification
                          ? Image.asset(
                              AppIcons.notification,
                              height: 35.h,
                              width: 35.h,
                            )
                          : Image.asset(
                              AppIcons.inactiveNotification,
                              height: 35.h,
                              width: 35.h,
                            ))
                ],
              )),
            ),
          ),
        ),
        body: Consumer<ScheduleHistoryProvider>(
          builder: (context, value, child) {
            return TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                UpcomingScreen(data: value.upcomingTickets  , title: AppLocalizations.of(context)!.upcoming,),
                CompletedScreen(data: value.completeTaskList , title: AppLocalizations.of(context)!.completed,),
                DeclineScreen(data : value.declinedList , title : AppLocalizations.of(context)!.decline),
              ],
            );
          },
        ),
      ),
    );
  }

  void _navigateToNotification(BuildContext context) {
    Navigator.of(context)
        .push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child:
                NotificationScreen(), // Replace with your notification screen
          );
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
    )
        .then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await Provider.of<ScheduleHistoryProvider>(context, listen: false)
              .getUpcomingTicketsData(context);
        });
      });
    });
  }
}
