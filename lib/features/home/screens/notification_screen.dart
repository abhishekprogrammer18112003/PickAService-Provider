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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.notifications,
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
          child: RefreshIndicator(
            onRefresh: () async {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await Provider.of<NotificationProvider>(context, listen: false)
              .getNotificationDataWithoutTimer(context);
        });
      },
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
                      AppLocalizations.of(context)!.nonewnotificaitons,
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









