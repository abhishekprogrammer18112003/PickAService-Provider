// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/features/home/data/home_provider.dart';
import 'package:pick_a_service/features/home/screens/orders_screen.dart';
import 'package:pick_a_service/features/service%20history/data/schedule_history_provider.dart';
import 'package:pick_a_service/features/service%20history/models/decined_model.dart';
import 'package:pick_a_service/features/service%20history/models/schedule_history_model.dart';
import 'package:pick_a_service/features/service%20history/screens/pending_orders_details_screen.dart';
import 'package:pick_a_service/features/service%20history/widgets/declined_orders_widget.dart';
import 'package:pick_a_service/features/service%20history/widgets/schedule_history_screen_widget.dart';
import 'package:pick_a_service/route/app_pages.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DeclineScreen extends StatefulWidget {
  String title;
  List<DeclineModel> data;
  DeclineScreen({super.key, required this.data, required this.title});

  @override
  State<DeclineScreen> createState() => _DeclineScreenState();
}

class _DeclineScreenState extends State<DeclineScreen> {
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleHistoryProvider>(context);
    return RefreshIndicator(
      color: Colors.blue,
      onRefresh: () async {
        await provider.declinedTask();
        // await provider.completeTask();
      },
      child: !provider.isUpcomingLoading
          ? !provider.declinedList.isEmpty
              ? ListView.builder(
                  itemCount: widget.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });

                        // CustomNavigator.pushTo(
                        //         context, AppPages.pendingordersdetails,
                        //         data : widget.data[index] , arguments: {
                        //           'day' : 'upcoming' , 'ind' : index
                        //         })
                        //     .then(
                        //   (value) {
                        //     provider.getUpcomingTicketsData(context);

                        //     setState(() {
                        //       _selectedIndex = -1;
                        //     });
                        //   },
                        // );

                              _navigate(context, index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? Colors.grey.withOpacity(
                                  0.5) // Change to the desired color
                              : Colors.transparent,
                        ),
                        child: DeclinedOrdersScreenWidget(
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
    );
  }

  void _navigate(BuildContext context, int index) {
    final provider = Provider.of<ScheduleHistoryProvider>(context , listen : false);
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
