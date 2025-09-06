import 'package:dayas/styles/colors.dart';
import 'package:dayas/widget/herocard.dart';
import 'package:dayas/widget/highlighted_subtitle.dart';
import 'package:dayas/widget/input.dart';
import 'package:dayas/widget/subtile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

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
          GetHeroCard ("olivia redrigo" , "singer" , "assets/images/test_hero.png" , AppColors.purplePastel)
        ],
      )
     
      )
    );
  }
}
