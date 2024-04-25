// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/utils/custom_spacers.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/data/home_provider.dart';
import 'package:pick_a_service/features/home/models/accepted_models.dart';
import 'package:pick_a_service/features/home/screens/orders_screen.dart';
import 'package:pick_a_service/features/home/widgets/orders_widget.dart';
import 'package:provider/provider.dart';

class DateScreen extends StatefulWidget {
  List<AcceptedOrdersModel> data;
  String title;
  DateScreen({super.key, required this.data, required this.title});

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return Scaffold(
      // backgroundColor: AppColors.primary,
        body: RefreshIndicator(
      color: Colors.blue,
      onRefresh: () async {
        await provider.getacceptedOrders();
      },
      child: !provider.isOrdersLoading
          ? widget.data.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CustomSpacers.height12,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "Orders",
                        style: TextStyle(
                            fontSize: 24.h, fontWeight: FontWeight.w600),
                      ),
                    ),
                    CustomSpacers.height8,
                    _buildOrders()
                  ],
                )
              : Center(
                  child: Text(
                    "No orders for ${widget.title} !",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )
          : Center(
              child: CircularProgressIndicator(),
            ),
    ));
  }

  _buildOrders() => SizedBox(
      height: 520.h,
      child: ListView.builder(
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
                  ? Colors.grey.withOpacity(0.5) // Change to the desired color
                  : Colors.transparent,
            ),
            child: OrdersWidget(data: widget.data[index]), // Your OrdersWidget
          ),);
            
     
}));
    
      
  void _navigate(BuildContext context, int index) {
    Navigator.of(context)
        .push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: OrdersScreen(
              arguments: {"day": widget.title, "ind": index},
              data: widget.data[index],
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
        .then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<HomeProvider>(context, listen: false).getacceptedOrders();
      });

      setState(() {
        _selectedIndex = -1;
      });
    });
  }
}
