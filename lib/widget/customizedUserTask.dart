import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';

Widget getUserTask(
    String taskname, String start, String end, bool isDone, Color color) {
  return Container(
    width: 330,
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    margin: const EdgeInsets.only(bottom : 20 ),
    decoration: BoxDecoration(
      color: (isDone) ? color : Colors.white,
      border: Border.all(
        color: color,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(10), 
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          taskname,
          style: LineStyles.context.copyWith(color: AppColors.lightGrey),
        ),
        Text(
          (end != "") ? "$start - $end" : start,
          style: LineStyles.context.copyWith(color: AppColors.lightGrey),
        ),
      ],
    ),
  );
}
