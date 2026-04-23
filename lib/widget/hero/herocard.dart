import 'package:dayas/models/heroModel.dart';
import 'package:dayas/screens/HeroRoutineScreen.dart';

import 'package:flutter/material.dart';
import 'package:dayas/widget/hero/heroPhoto.dart'; 
import 'package:dayas/widget/hero/heroDefinition.dart';
Widget getHeroCard (BuildContext context,String Name , String Category , String ImagePath , Color color , Heromodel hero ) {
  return GestureDetector(
    child : Container(
    width : 179 , 
    child : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getHeroPhoto(ImagePath , color ) , 
        SizedBox(height: 10,),
        getHeroDef (Name , Category)
      ],
    )
  ), 
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>HeroRoutineScreen( hero  : hero ))
    );
  },
  ); 
}

