// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/constants/app_data.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/models/accepted_models.dart';
import 'package:pick_a_service/main.dart';

class OrdersWidget extends StatefulWidget {
  AcceptedOrdersModel data;
  OrdersWidget({super.key, required this.data});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  List<int> rgba = [];
  // String CategoryNameEn = "",
  //     SubCategoryNameEn = "",
  //     CategoryNameAr = "",
  //     SubCategoryNameAr = "",
  //     date = "",
  //     time = "",
  //     ticketNo = "";
  @override
  void initState() {
    super.initState();

    rgba = AppData.hexToRgba(widget.data.color);
    print("Language");
    print(lang);
  }

  @override
  Widget build(BuildContext context) {
    return lang == "en"
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Container(
              height: 117.h,
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
              child: Column(
                children: [
                  _buildTopWidgetEn(),
                  _buildbottomWidgetEn(),
                ],
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Container(
              height: 117.h,
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
                      // ,
                      //  SizedBox(
                      //     height: 30.h,
                      //     width: 30.w,
                      //     child: Image.network(widget.data.imgUrl)),

                      // Image.network(
                      //   BASE_URL +  widget.data.img,
                      //   loadingBuilder: (BuildContext context, Widget child,
                      //       ImageChunkEvent? loadingProgress) {
                      //     if (loadingProgress == null) {
                      //       return child;
                      //     } else {
                      //       return CircularProgressIndicator(
                      //         value: loadingProgress.expectedTotalBytes != null
                      //             ? loadingProgress.cumulativeBytesLoaded /
                      //                 loadingProgress.expectedTotalBytes!
                      //             : null,
                      //       );
                      //     }
                      //   },
                      //   errorBuilder: (context, error, stackTrace) {
                      //     return Text('Error loading image');
                      //   },
                      // ),
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

              Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      widget.data.WorkStatus,
                      style: TextStyle(
                          color: AppColors.black, fontWeight: FontWeight.w500),
                    ),
                  ))
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
            _buildWidget("Order", widget.data.ticketNo),
            _buildWidget("Date", widget.data.date),
            _buildWidget("Time", widget.data.time),
          ],
        ),
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

                      // SizedBox(
                      //     height: 30.h,
                      //     width: 30.w,
                      //     child: Image.network(widget.data.imgUrl)),

                      // Image.network(
                      //   BASE_URL +  widget.data.img,
                      //   loadingBuilder: (BuildContext context, Widget child,
                      //       ImageChunkEvent? loadingProgress) {
                      //     if (loadingProgress == null) {
                      //       return child;
                      //     } else {
                      //       return CircularProgressIndicator(
                      //         value: loadingProgress.expectedTotalBytes != null
                      //             ? loadingProgress.cumulativeBytesLoaded /
                      //                 loadingProgress.expectedTotalBytes!
                      //             : null,
                      //       );
                      //     }
                      //   },
                      //   errorBuilder: (context, error, stackTrace) {
                      //     return Text('Error loading image');
                      //   },
                      // ),
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

              Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      widget.data.WorkStatus,
                      style: TextStyle(
                          color: AppColors.black, fontWeight: FontWeight.w500),
                    ),
                  ))
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
            _buildWidget("Order", widget.data.ticketNo),
            _buildWidget("Date", widget.data.date),
            _buildWidget("Time", widget.data.time),
          ],
        ),
      );
}
