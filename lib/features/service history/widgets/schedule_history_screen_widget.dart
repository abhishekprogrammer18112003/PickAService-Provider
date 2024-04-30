// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_icons.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/service%20history/models/schedule_history_model.dart';
import 'package:pick_a_service/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScheduleHistoryScreenWidget extends StatefulWidget {
  ScheduleHistoryModel data;
  ScheduleHistoryScreenWidget({super.key, required this.data});

  @override
  State<ScheduleHistoryScreenWidget> createState() =>
      _ScheduleHistoryScreenWidgetState();
}

class _ScheduleHistoryScreenWidgetState
    extends State<ScheduleHistoryScreenWidget> {
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
            _buildWidget(AppLocalizations.of(context)!.orders, widget.data.ticketNo, AppColors.primary),
            _buildWidget(AppLocalizations.of(context)!.date, widget.data.date, AppColors.primary),
            _buildWidget(AppLocalizations.of(context)!.time, widget.data.time, AppColors.primary),
            widget.data.WorkStatus == "Assigned" ||
                    widget.data.WorkStatus == "Reassigned"
                ? _buildWidget(AppLocalizations.of(context)!.status, "Pending", Colors.red)
                : widget.data.WorkStatus == "Accepted"
                    ? _buildWidget(AppLocalizations.of(context)!.status, "Accepted", Colors.green)
                    : _buildWidget(
                        AppLocalizations.of(context)!.status, widget.data.WorkStatus, AppColors.primary),
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
            _buildWidget(AppLocalizations.of(context)!.orders, widget.data.ticketNo, AppColors.primary),
            _buildWidget(AppLocalizations.of(context)!.date, widget.data.date, AppColors.primary),
            _buildWidget(AppLocalizations.of(context)!.time, widget.data.time, AppColors.primary),
            widget.data.WorkStatus == "Assigned" ||
                    widget.data.WorkStatus == "Reassigned"
                ? _buildWidget(AppLocalizations.of(context)!.status, "Pending", Colors.red)
                : widget.data.WorkStatus == "Accepted"
                    ? _buildWidget(AppLocalizations.of(context)!.status, "Accepted", Colors.green)
                    : _buildWidget(
                        AppLocalizations.of(context)!.status, widget.data.WorkStatus, AppColors.primary),
          ],
        ),
      );
}
