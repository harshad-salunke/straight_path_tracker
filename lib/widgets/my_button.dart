import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  String title;
  double height;
  double width;
  Function() onPressed;
  double fontsize;
  double radius;
  FontWeight fontWeight;
  Color bg_color;
  Color text_color;
  MyElevatedButton(
      {required this.title,
        required this.height,
        required this.width,
        required this.fontsize,
        required this.radius,
        required this.bg_color,
        required this.text_color,
        required  this.fontWeight,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:bg_color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(

            color: text_color,
            fontWeight: fontWeight,
            fontFamily: "Brand-Bold",
            fontSize: fontsize,
          ),
        ),
      ),
    );
  }
}
