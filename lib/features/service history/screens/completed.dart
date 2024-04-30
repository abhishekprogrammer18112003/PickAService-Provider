// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/service%20history/data/schedule_history_provider.dart';
import 'package:pick_a_service/features/service%20history/models/completed_task.dart';
// ignore: unused_import
import 'package:pick_a_service/features/service%20history/screens/pending_orders_details_completed.dart';
import 'package:pick_a_service/features/service%20history/screens/pending_orders_details_screen.dart';
import 'package:pick_a_service/main.dart';
import 'package:pick_a_service/ui/molecules/custom_drop_down.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompletedScreen extends StatefulWidget {
  String title;
  List<CompletedTasksModel> data;
  CompletedScreen({super.key, required this.data, required this.title});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  String status = "Completed";
  int _selectedIndex = -1;
  Set<String> item = { "Completed", "Paid", "Observation"};
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleHistoryProvider>(context);
    return RefreshIndicator(
      color: Colors.blue,
      onRefresh: () async {
        await provider.getUpcomingTicketsData(context);
        await provider.completeTask(status);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomDropdown(
                items: item,
                 
                hintText: "Completed",
                validator: (v) {},
                onChanged: (v) {
                  setState(() {
                    status = v!;
                  });
                  provider.completeTask(v!);
                }),
          ),

          CustomSpacers.height10,
          !provider.isUpcomingLoading
              ? !provider.completeTaskList.isEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            _navigate(context, index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedIndex == index
                                  ? Colors.grey.withOpacity(
                                      0.5) // Change to the desired color
                                  : Colors.transparent,
                            ),
                            child: ScheduleHistoryScreenWidgetCompleted(
                              data: widget.data[index],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(child: Text(AppLocalizations.of(context)!.noodata))
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, int index) {
    final provider =
        Provider.of<ScheduleHistoryProvider>(context, listen: false);
    Navigator.of(context)
        .push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: PendingOrdersDetailsScreen(
              arguments: {"day": widget.title, "ind": index},
              ticketId: widget.data[index].ticketId,
            ), // Replace with your notification screen
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
        .then(
      (value) {
        provider.getUpcomingTicketsData(context);
        setState(() {
          _selectedIndex = -1;
        });
      },
    );
  }
}

class ScheduleHistoryScreenWidgetCompleted extends StatefulWidget {
  CompletedTasksModel data;
  ScheduleHistoryScreenWidgetCompleted({super.key, required this.data});

  @override
  State<ScheduleHistoryScreenWidgetCompleted> createState() =>
      _ScheduleHistoryScreenWidgetCompletedState();
}

class _ScheduleHistoryScreenWidgetCompletedState
    extends State<ScheduleHistoryScreenWidgetCompleted> {
  @override
  Widget build(BuildContext context) {
    return lang == "en"
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Container(
              width: 343.w,
              height: 117.h,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 218, 218, 218),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildTopWidgetEn(),
                  _buildbottomWidgetEn(),
                ],
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Container(
              width: 343.w,
              height: 117.h,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 218, 218, 218),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildTopWidgetAr(),
                  _buildbottomWidgetAr(),
                ],
              ),
            ),
          );
  }

  _buildTopWidgetEn() => Container(
        height: 46.h,
        width: 343.w,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 111, 202, 229),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppIcons.airconditioning,
                        height: 22.h,
                        width: 30.w,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.CategoryNameEn,
                            style: TextStyle(
                                fontSize: 12.h,
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondary),
                          ),
                          Text(
                            widget.data.SubCategoryNameEn,
                            style: TextStyle(
                                fontSize: 10.h,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondary),
                          )
                        ],
                      ),
                    ]),
              ),
              // Icon(
              //   Icons.more_vert,
              //   color: AppColors.secondary,
              // )
            ],
          ),
        ),
      );

  _buildbottomWidgetEn() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 13.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildWidget(AppLocalizations.of(context)!.orders,
                widget.data.ticketNo, AppColors.primary),
            _buildWidget(AppLocalizations.of(context)!.date, widget.data.date,
                AppColors.primary),
            _buildWidget(AppLocalizations.of(context)!.time, widget.data.time,
                AppColors.primary),
            widget.data.WorkStatus == "Observation"
                ? _buildWidget(AppLocalizations.of(context)!.status,
                    widget.data.WorkStatus, Color.fromARGB(255, 255, 81, 0))
                : _buildWidget(AppLocalizations.of(context)!.status,
                    widget.data.WorkStatus, Color.fromARGB(255, 170, 0, 255)),
          ],
        ),
      );

  _buildWidget(String title, String subtitle, Color color) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.w600),
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 12.h, fontWeight: FontWeight.w500, color: color),
          )
        ],
      );

  _buildTopWidgetAr() => Container(
        height: 46.h,
        width: 343.w,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 111, 202, 229),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppIcons.airconditioning,
                        height: 22.h,
                        width: 30.w,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.CategoryNameAr,
                            style: TextStyle(
                                fontSize: 12.h,
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondary),
                          ),
                          Text(
                            widget.data.SubCategoryNameAr,
                            style: TextStyle(
                                fontSize: 10.h,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondary),
                          )
                        ],
                      ),
                    ]),
              ),
              // Icon(
              //   Icons.more_vert,
              //   color: AppColors.secondary,
              // )
            ],
          ),
        ),
      );

  _buildbottomWidgetAr() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 13.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildWidget(AppLocalizations.of(context)!.orders,
                widget.data.ticketNo, AppColors.primary),
            _buildWidget(AppLocalizations.of(context)!.date, widget.data.date,
                AppColors.primary),
            _buildWidget(AppLocalizations.of(context)!.time, widget.data.time,
                AppColors.primary),
            widget.data.WorkStatus == "Observation"
                ? _buildWidget(AppLocalizations.of(context)!.status,
                    widget.data.WorkStatus, Color.fromARGB(255, 255, 81, 0))
                : _buildWidget(AppLocalizations.of(context)!.status,
                    widget.data.WorkStatus, Color.fromARGB(255, 170, 0, 255)),
          ],
        ),
      );
}
