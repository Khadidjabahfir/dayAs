import 'package:flutter/material.dart';
Widget getHeroAvatar (String ImagePath , Color color ){
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color : color , 
          borderRadius: BorderRadius.circular(100), 
        ),
      ) , 
      Image.asset(ImagePath ,
      width : 80 ,
      height: 80 , 
      fit: BoxFit.cover
      )
    ],
  ); 
}