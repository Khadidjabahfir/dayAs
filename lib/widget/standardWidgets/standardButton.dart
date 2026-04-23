import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';
Widget getButton (String line , Color color , {VoidCallback? onTap} ) {
  return GestureDetector(
    onTap: onTap,
    child:  Container(
    width: 150,
    height: 45,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10)
    ),
    child : 
    Center( child : Text(line , style : LineStyles.btnText.copyWith(color : AppColors.darkGrey , fontWeight: FontWeight.normal)), 
  ),
  ),
  ); 
}
