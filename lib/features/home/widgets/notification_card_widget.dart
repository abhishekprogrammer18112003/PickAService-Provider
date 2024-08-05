// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:pick_a_service/core/constants/app_data.dart';
import 'package:pick_a_service/core/constants/app_icons.dart';
import 'package:pick_a_service/core/utils/custom_spacers.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/models/notification_model.dart';
import 'package:pick_a_service/main.dart';
import 'package:pick_a_service/ui/global%20widegts/acceptrejectwidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/constants/app_colors.dart';

class NotificationCardWidget extends StatefulWidget {
  NotificationModel data;
  NotificationCardWidget({super.key, required this.data});

  @override
  State<NotificationCardWidget> createState() => _NotificationCardWidgetState();
}

class _NotificationCardWidgetState extends State<NotificationCardWidget> {
  List<int> rgba = [];
  String date = "";
  String time = "";
  late Color customColor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    customColor = AppData.hexToColor(widget.data.color);
  }

  @override
  Widget build(BuildContext context) {
    return lang == "en"
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: 343.w,
              // height: 283.h,
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
              child: Column(
                children: [
                  _buildTopWidgetEn(),
                  _buildbottomWidgetEn(),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: 343.w,
              // height: 283.h,
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
        height: 60.h,
        width: 343.w,
        decoration: BoxDecoration(
          color: customColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      CustomSpacers.width14,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.CategoryNameEn,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondary),
                          ),
                          Text(
                            widget.data.SubCategoryNameEn,
                            style: TextStyle(
                                fontSize: 10,
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
              SizedBox(
                child: Row(
                  children: [
                    widget.data.Priority == "top"
                        ? Icon(
                            Icons.arrow_circle_up_outlined,
                            color: Colors.green,
                          )
                        : widget.data.Priority == "medium"
                            ? Icon(
                                Icons.compare_arrows_outlined,
                                color: Colors.orange,
                              )
                            : Icon(
                                Icons.arrow_circle_down_outlined,
                                color: Colors.red,
                              ),
                    CustomSpacers.width8,
                    Text(
                      widget.data.Priority,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  _buildbottomWidgetEn() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 13),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildWidget(
                    AppLocalizations.of(context)!.orders, widget.data.ticketNo),
                _buildWidget(
                    AppLocalizations.of(context)!.date, widget.data.date),
                _buildWidget(
                    AppLocalizations.of(context)!.time, widget.data.time),
                _buildWidget(
                    AppLocalizations.of(context)!.status, widget.data.WorkStatus),
              ],
            ),
            CustomSpacers.height16,
            Divider(
              thickness: 2,
            ),
            CustomSpacers.height16,
            _buildRowWidget(AppLocalizations.of(context)!.name,
                ":  ${widget.data.Fullname}"),
            CustomSpacers.height8,
            _buildRowWidget(AppLocalizations.of(context)!.mobile,
                ":  ${widget.data.PhoneNo}"),
            CustomSpacers.height8,
            _buildRowWidget(AppLocalizations.of(context)!.address,
                ":  ${widget.data.NameOfAddress}"),
            CustomSpacers.height16,
            AcceptRejectWidget(id: widget.data.ticketId)
          ],
        ),
      );

  _buildRowWidget(String title, String value) => Row(
        children: [
          SizedBox(
              width: 105.w,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12.w,
                  fontWeight: FontWeight.w600,
                ),
              )),
          SizedBox(
            width: 188.w,
            child: Text(value,
                style: TextStyle(
                    fontSize: 12.w,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
          )
        ],
      );

  _buildWidget(String title, String subtitle) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.w600),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.w500),
          ),
        ],
      );

  _buildTopWidgetAr() => Container(
        height: 60.h,
        width: 343.w,
        decoration: BoxDecoration(
          color: customColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      CustomSpacers.width14,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.CategoryNameEn,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondary),
                          ),
                          Text(
                            widget.data.SubCategoryNameEn,
                            style: TextStyle(
                                fontSize: 10,
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
              SizedBox(
                child: Row(
                  children: [
                    widget.data.Priority == "top"
                        ? Icon(
                            Icons.arrow_circle_up_outlined,
                            color: Colors.green,
                          )
                        : widget.data.Priority == "medium"
                            ? Icon(
                                Icons.compare_arrows_outlined,
                                color: Colors.orange,
                              )
                            : Icon(
                                Icons.arrow_circle_down_outlined,
                                color: Colors.red,
                              ),
                    CustomSpacers.width8,
                    Text(
                      widget.data.Priority,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  _buildbottomWidgetAr() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 13),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildWidget(
                    AppLocalizations.of(context)!.orders, widget.data.ticketNo),
                _buildWidget(
                    AppLocalizations.of(context)!.date, widget.data.date),
                _buildWidget(
                    AppLocalizations.of(context)!.time, widget.data.time),
                _buildWidget(
                    AppLocalizations.of(context)!.status, widget.data.WorkStatus),
              ],
            ),
            CustomSpacers.height16,
            Divider(
              thickness: 2,
            ),
            CustomSpacers.height16,
            _buildRowWidget(AppLocalizations.of(context)!.name,
                ":  ${widget.data.Fullname}"),
            CustomSpacers.height8,
            _buildRowWidget(AppLocalizations.of(context)!.mobile,
                ":  ${widget.data.PhoneNo}"),
            CustomSpacers.height8,
            _buildRowWidget(AppLocalizations.of(context)!.address,
                ":  ${widget.data.NameOfAddress}"),
            CustomSpacers.height16,
            AcceptRejectWidget(id: widget.data.ticketId)
          ],
        ),
      );
}
