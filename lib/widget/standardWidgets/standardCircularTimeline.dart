import 'package:flutter/material.dart';
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