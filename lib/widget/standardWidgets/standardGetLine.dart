import 'package:flutter/material.dart';
Widget getLine(Color color , double height ) {
  return Container(
    height: height,
    width: 1.5,
    decoration: BoxDecoration(
      color: color
    ),
  ); 
}