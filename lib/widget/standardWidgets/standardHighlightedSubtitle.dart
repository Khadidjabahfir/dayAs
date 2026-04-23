import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';

Widget highlightedSubtitle(BuildContext context, String line, Widget page) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    },
    child: Text(
      line,
      style: LineStyles.act_subtitle.copyWith(
        decoration: TextDecoration.underline,
      ),
    ),
  );
}
