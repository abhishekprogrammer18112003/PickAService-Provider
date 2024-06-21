// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pick_a_service/core/constants/app_colors.dart';
import 'package:pick_a_service/core/constants/app_icons.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/service%20history/data/schedule_history_provider.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:pick_a_service/ui/global%20widegts/custom_button_accept_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AcceptRejectWidget extends StatefulWidget {
  int id;
  AcceptRejectWidget({super.key, required this.id});

  @override
  State<AcceptRejectWidget> createState() => _AcceptRejectWidgetState();
}

class _AcceptRejectWidgetState extends State<AcceptRejectWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleHistoryProvider>(context);
    return !provider.isAcceptDeclineLoading
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                      await provider.acceptOrder(widget.id, "Accept", context);
                      CustomNavigator.pop(context);
                    },
                    child: CustomAcceptButtonWidget(
                      text: AppLocalizations.of(context)!.accept,
                      height: 34.h,
                      width: 107.w,
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
                      await provider.declineOrder(widget.id, context);
                    },
                    child: CustomAcceptButtonWidget(
                      text: AppLocalizations.of(context)!.decline,
                      height: 34.h,
                      width: 107.w,
                      radius: 7.r,
                      image: AppIcons.decline,
                      style: TextStyle(
                          fontSize: 10.w,
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondary),
                      color: Color.fromARGB(255, 248, 38, 51),
                    ))
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
