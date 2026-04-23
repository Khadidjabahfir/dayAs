import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:dayas/widget/hero/standardHeroprofile.dart';
import 'package:flutter/material.dart';
Widget getHeroCircularProfile (String ImagePath, Color color , String Name , String Category){
  return Column (children: [
    getHeroAvatar(ImagePath , color ), 
    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height : 10),
      Text(Name , style: LineStyles.context.copyWith(color :AppColors.darkGrey , fontWeight: FontWeight.normal)) , 
      Text(Category , style: LineStyles.subtitle.copyWith(color : AppColors.lightGrey , fontWeight: FontWeight.normal))
    ],
  )
    
  ],
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  ); 
}