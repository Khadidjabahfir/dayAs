import 'package:flutter/material.dart';
Widget getHeroAvatar (String ImagePath , Color color ){
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          color : color , 
          borderRadius: BorderRadius.circular(130), 
        ),
      ) , 
      Image.asset(ImagePath ,
      width : 100 ,
      height: 100 , 
      fit: BoxFit.cover
      )
    ],
  ); 
}