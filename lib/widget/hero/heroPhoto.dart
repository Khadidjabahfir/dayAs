import 'package:flutter/material.dart';
Widget getHeroPhoto (String ImagePath , Color color) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 170,
        height: 150,
        decoration: BoxDecoration(
          color : color , 
          borderRadius: BorderRadius.circular(20), 
        ),
      ) , 
      Image.asset(ImagePath ,
      width : 132 ,
      height: 132 , 
      fit: BoxFit.cover
      )
    ],
  ); 
}