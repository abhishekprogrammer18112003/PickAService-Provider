import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';

class CustomContainerWidget extends StatefulWidget {
  String image;
  String title;
  CustomContainerWidget({super.key , required this.image , required this.title});

  @override
  State<CustomContainerWidget> createState() => _CustomContainerWidgetState();
}

class _CustomContainerWidgetState extends State<CustomContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59.h,
      width: 303.w,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 75, 75, 75),
        borderRadius: BorderRadius.circular(8),
      ),


      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal  :24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(widget.image , height: 24,width: 40,) ,
            
            CustomSpacers.width16,
              Text(widget.title , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w500 , color: AppColors.secondary),),
          ],
        ),
      ),
    );
  }
}