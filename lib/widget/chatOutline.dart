import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';

Widget GetChatOutline(Color color, String imagePath, String heroName) {
  const subtitle = "fans"; 
  return Container(
    width: 350, 
    
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.fromLTRB(40, 10, 40, 10), 
    decoration: BoxDecoration(
      border: Border.all(color: color, width: 1),
      borderRadius: BorderRadius.circular(16),
      color: Colors.white
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              heroName,
              style:LineStyles.subtitle.copyWith(color: AppColors.darkGrey),
            ),
            Text(
              subtitle,
              style: LineStyles.subtitle.copyWith(
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
