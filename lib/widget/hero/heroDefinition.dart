import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';

Widget getHeroDef (String Name , String Category ){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(Name , style: LineStyles.context.copyWith(color :AppColors.darkGrey)) , 
      Text(Category , style: LineStyles.subtitle.copyWith(color : AppColors.lightGrey))
    ],
  );
}