import 'package:flutter/material.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';

class CustomTask extends StatelessWidget {
  final String taskName;
  final String start;
  final String end;
  final Color color;
  final bool isDone;
  final VoidCallback onDoubleTap;
  final VoidCallback? onTap;

  const CustomTask({
    super.key,
    required this.taskName,
    required this.start,
    required this.end,
    required this.color,
    required this.isDone,
    required this.onDoubleTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      onTap: onTap,
      child: Container(
        width: 300,
        height: 75,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(left: 17 ),
        decoration: BoxDecoration(
          color: isDone ? color : Colors.white,
          border: Border.all(
            color: color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              taskName,
              style: LineStyles.secodHeader.copyWith(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              (end != "") ? "$start - $end" : start,
              style: LineStyles.context.copyWith(
                color: AppColors.lightGrey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
