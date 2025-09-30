import 'package:dayas/models/heroModel.dart';
import 'package:dayas/screens/HeroRoutineScreen.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';
Widget GetHeroCard (BuildContext context,String Name , String Category , String ImagePath , Color color , Heromodel hero ) {
  return GestureDetector(
    child : Container(
    width : 179 , 
    child : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GetHeroPhoto(ImagePath , color ) , 
        SizedBox(height: 10,),
        GetHeroDef (Name , Category)
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
Widget GetHeroPhoto (String ImagePath , Color color) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 170,
        height: 150,
        decoration: BoxDecoration(
          color : color , 
          borderRadius: BorderRadius.circular(20), 
        ),
      ) , 
      Image.asset(ImagePath ,
      width : 132 ,
      height: 132 , 
      fit: BoxFit.cover
      )
    ],
  ); 
}
Widget GetHeroDef (String Name , String Category ){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(Name , style: LineStyles.context.copyWith(color :AppColors.darkGrey)) , 
      Text(Category , style: LineStyles.subtitle.copyWith(color : AppColors.lightGrey))
    ],
  );
}