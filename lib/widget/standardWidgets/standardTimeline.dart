import 'package:flutter/material.dart';
import 'package:dayas/widget/standardWidgets/standardCircularTimeline.dart';
import 'package:dayas/widget/standardWidgets/standardGetLine.dart';

Widget getTimeline (Color color , double height ) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      getCircularTimeline(color), 
      getLine(color, height)
    ],
  );
}

