import 'package:dayas/models/heroModel.dart';
import 'package:dayas/models/routineTaskModel.dart';
import 'package:dayas/screens/ExploreScreen.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/widget/standardButton.dart';
import 'package:dayas/widget/standardHeroCircularProfile.dart';
import 'package:dayas/widget/standardHerotask.dart';
import 'package:dayas/widget/standardTimeline.dart';
import 'package:flutter/material.dart';
class HeroRoutineScreen extends StatefulWidget {
  final Heromodel hero;

  const HeroRoutineScreen({Key? key, required this.hero}) : super(key: key);

  @override
  State<HeroRoutineScreen> createState() => _HeroRoutineScreenState();
}

class _HeroRoutineScreenState extends State<HeroRoutineScreen> {
  @override
  Widget build (BuildContext context ) {
    Heromodel hero = widget.hero; 
    Color color = getColorFromString(hero.color); 
    return Center (
      child : Column(children: [
        SizedBox(height : 40), 
        GetHeroCircularProfile(hero.imageUrl , color , hero.name ,hero.role), 
        SizedBox(height: 20,), 
        getTasks(hero) , 
        SizedBox(height: 20,), 
        getButton('Customize', color) , 
      ],
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,), 
    ); 
  }
}
Widget getTasks(Heromodel hero) {
  final tasks = hero.tasks ?? [];

  return ListView.builder(
    shrinkWrap: true, 
    physics: NeverScrollableScrollPhysics(), 
    padding: const EdgeInsets.all(5),
    itemCount: tasks.length,
    itemBuilder: (context, index) {
      final task = tasks[index];
      return heroTimelineTask(task); 
    },
  );
}
Widget heroTimelineTask (routineTasksModel task ) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getTimeline(getColorFromString(task.taskColor) , 70) , 
          SizedBox(width: 25 ,), 
          getHeroTask(
            task.taskName,
            task.taskStart,
            task.taskEnd,
            false,
            getColorFromString(task.taskColor),
          )
        ],
      ); 
}

