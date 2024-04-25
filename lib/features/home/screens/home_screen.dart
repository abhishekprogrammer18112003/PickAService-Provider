// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/data/home_provider.dart';
import 'package:pick_a_service/features/home/data/notification_provider.dart';
import 'package:pick_a_service/features/home/screens/date_screen.dart';
import 'package:pick_a_service/features/home/screens/notification_screen.dart';
import 'package:pick_a_service/features/profile/data/profile_provider.dart';
import 'package:pick_a_service/notification_service.dart';
import 'package:pick_a_service/route/app_pages.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeProvider>(context, listen: false)
          .getacceptedOrders();
      await Provider.of<NotificationProvider>(context, listen: false)
          .getNotificationData(context);

      await Provider.of<ProfileProvider>(context, listen: false)
          .getPersonalData(context);

      final provider = Provider.of<ProfileProvider>(context, listen: false);

      provider.getName(provider.profileDataModel["FullName"]);
      print(provider.name);
    });
  }

  NotificationService service = NotificationService();

  @override
  Widget build(BuildContext context) {
    final notiProvider = Provider.of<NotificationProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.h), // Custom height
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: AppBar(
                backgroundColor: AppColors.primary,
                elevation: 0,
                bottom: TabBar(
                  indicatorWeight: 7,
                  indicatorColor: AppColors.secondary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle:
                      TextStyle(fontSize: 14.h, fontWeight: FontWeight.w600),
                  labelColor: AppColors.white,
                  unselectedLabelColor:
                      const Color.fromARGB(255, 185, 185, 185),
                  tabs: [
                    Tab(text: 'TODAY'),
                    Tab(text: 'TOMORROW'),
                    Tab(text: 'THIS WEEK'),
                  ],
                ),
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
                  child: Container(
                      // Custom height
                      //  demonstration
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppIcons.app_logo,
                        color: AppColors.secondary,
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
          ),
          body: Consumer<HomeProvider>(builder: ((context, value, child) {
            return TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                DateScreen(
                  data: value.acceptedTodayOrdersList,
                  title: "Today",
                ),
                DateScreen(
                  data: value.acceptedTomorrowOrdersList,
                  title: "Tomorrow",
                ),
                DateScreen(
                  data: value.acceptedThisWeekOrdersList,
                  title: "This Week",
                ),
              ],
            );
          }))),
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
        Provider.of<HomeProvider>(context, listen: false).getacceptedOrders();
      });
    });
  }
}
