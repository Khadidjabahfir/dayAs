import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';

Widget getHeroTask(String taskname , String start , String end , bool isDone , Color color ) {
  return Container(
    width: 300,
    height: 85,
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.only(left: 17),
    decoration: BoxDecoration( 
      color : (isDone) ? color : (Colors.white),
      border: Border.all(
        color: color,
        width: 2, 
      ), 
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start ,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        Text(taskname , style: LineStyles.secodHeader.copyWith(color: AppColors.darkGrey , fontWeight: FontWeight.normal )), 
        SizedBox(height: 2,), 
        Text((end!="" )? start + " - " + end : start , style: LineStyles.context.copyWith(color: AppColors.lightGrey ,fontWeight: FontWeight.normal ) ), 
      ],
    ),
  ); 
}