import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:dayas/widget/standardButton.dart';
import 'package:flutter/material.dart';


class EndingTheChallengeRoutine extends StatelessWidget {
  final double score ; 
  const EndingTheChallengeRoutine({Key? key, required this.score}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('DayAs',
              style:LineStyles.header),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/yohoo.png' ,height: 104, width: 76 ) , 
              Text('yohoo' , style : LineStyles.subtitle.copyWith(color : AppColors.lightGrey ,  fontWeight: FontWeight.normal)), 
              SizedBox(height : 40 ), 
              Text("You have finished your challenage" , style : LineStyles.context.copyWith(color : AppColors.lightGrey , fontSize: 20 , fontWeight: FontWeight.normal)), 
              SizedBox(height : 40 ), 
              getButton("Claim", AppColors.yellowPastel) ,
              SizedBox(height : 5 ), 
              Text('click the button to collect ' + score.toString() + " coins" , style: LineStyles.act_subtitle.copyWith(fontWeight: FontWeight.normal)) 
            ]),
        )
    ); 
  }
}