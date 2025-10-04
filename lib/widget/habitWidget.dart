import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';

Widget GetHabit(String habitName, bool isdone, {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isdone 
            ? AppColors.yellowPastel 
            : Colors.white,                       
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.yellowPastel,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          habitName,
          style: LineStyles.context,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
