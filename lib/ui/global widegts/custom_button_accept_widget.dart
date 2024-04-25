import 'package:flutter/material.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';

class CustomAcceptButtonWidget extends StatefulWidget {
  double height ; 
  double width;
  String image;
  String text;
  double radius;
  TextStyle style;
  Color color;
  bool isLoading ;
   CustomAcceptButtonWidget({super.key, required this.height , required this.width , required this.image , required this.color, required this.radius , required this.style , required this.text , this.isLoading =  false});

  @override
  State<CustomAcceptButtonWidget> createState() => _CustomAcceptButtonWidgetState();
}

class _CustomAcceptButtonWidgetState extends State<CustomAcceptButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return !widget.isLoading ?  Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.radius)),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(widget.image , height: 18.h, width: 17.w, ) , 
          SizedBox(width: 5.w,),
          Text(widget.text , style:  widget.style,)
        ],
      ),
    ) : const Center(
      child: CircularProgressIndicator(),
    );
  }
}