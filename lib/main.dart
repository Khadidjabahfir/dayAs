import 'package:dayas/screens/SignUpScreen.dart';
import 'package:dayas/screens/chatScreen.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/widget/chatOutline.dart';
import 'package:dayas/widget/customizedUserTask.dart';
import 'package:dayas/widget/herocard.dart';
import 'package:dayas/widget/navBarWidget.dart';
import 'package:dayas/widget/standardHerotask.dart';
//import 'package:dayas/widget/highlighted_subtitle.dart';
import 'package:dayas/widget/standardInput.dart';
import 'package:dayas/widget/standardSubtitle.dart';
import 'package:dayas/widget/standardTimeline.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Signupscreen(), 
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body : Center(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetInput("Email" , "Enter your email"),
          Subtitle ("I accept the terms and privacy policy"), 
          // Hightlighted_Subtitle("Log_in" , Page)
          GetHeroCard ("olivia redrigo" , "singer" , "assets/images/test_hero.png" , AppColors.purplePastel),
          getTimeline(AppColors.purplePastel , 100), 
          getHeroTask("wake up" , "8:30am" , "" , false  , AppColors.purplePastel), 
          SizedBox(height: 20,),
          getUserTask("wake up" , "8:30am" , "" , false , AppColors.purplePastel), 
          GetChatOutline(
            AppColors.purplePastel, 
            "assets/images/test_hero.png", 
            "olivia rodrigo"
          ),

        ],
      )
     
      )
    );
  }
}
