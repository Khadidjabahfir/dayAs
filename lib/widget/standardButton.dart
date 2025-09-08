import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';
Widget getButton (String line , Color color , {VoidCallback? onTap} ) {
  return GestureDetector(
    onTap: onTap,
    child:  Container(
    child : Text(line , style : LineStyles.btnText), 
    decoration: BoxDecoration(
      color: color , 
    ),
  ),
  )
 ; 
}