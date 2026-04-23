import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';
Widget getAsmallerbtn (String line , Color color , {VoidCallback? onTap} ) {
    return GestureDetector(
      onTap: onTap,
      child:  Container(
      width: 120,
      height: 35,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      child : 
      Center( child : Text(line , style : LineStyles.subtitle.copyWith(color : AppColors.darkGrey , fontWeight: FontWeight.normal)), 
    ),
    ),
    ); 
}