import 'package:flutter/material.dart';

Widget getTimeline (Color color , double height ) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      getCircularTimeline(color), 
      getLine(color, height)
    ],
  );
}
Widget getCircularTimeline (Color color ) {
  return Container(
    width : 20 , 
    height: 20, 
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      border: Border.all(
        color: color,
        width: 2,     
      )
    ),
  ); 
}
Widget getLine(Color color , double height ) {
  return Container(
    height: height,
    width: 1.5,
    decoration: BoxDecoration(
      color: color
    ),
  ); 
}