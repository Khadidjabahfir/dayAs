import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:dayas/widget/habitWidget.dart';
import 'package:dayas/widget/standardWidgets/standardButton.dart';
import 'package:dayas/widget/standardWidgets/standardInput.dart';
import 'package:flutter/material.dart';

class AddHabits extends StatefulWidget {
  const AddHabits({Key? key}) : super(key: key);

  @override
  State<AddHabits> createState() => _AddHabitsState();
}

class _AddHabitsState extends State<AddHabits> {
  final TextEditingController _habitController = TextEditingController();
  final List<String> _habits = [];

  @override
  void dispose() {
    _habitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height : 50 ), 
            Text(
              "Your Habits",
              style: LineStyles.secodHeader.copyWith(color : AppColors.darkGrey),
            ),
            SizedBox(height: 30),
            getInput("Habits", "Habit name" , controller: _habitController),
            SizedBox(height: 16),
            getButton("Add Habit", AppColors.yellowPastel ,  onTap: () {
                final habit = _habitController.text.trim();
                if (habit.isNotEmpty) {
                  setState(() {
                    _habits.add(habit);
                    _habitController.clear();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Habit added!")),
                  );
                }
              },
            ),
            SizedBox(height : 30) , 
            
            Expanded(
              child: _habits.isNotEmpty
                  ? ListView.builder(
                      itemCount: _habits.length,
                      itemBuilder: (context, index) {
                        final habitName = _habits[index]; 
                        return SizedBox(
                          width : 200 , 
                          child: getHabit(habitName, false),
                        );
                      },
                    )
                  : Center(
                      child:Center ( child : Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Image.asset("assets/images/ugh.png" , width : 100 , height : 100),
                      Text(
                        "No habits added yet",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 20),
                      
                    ],)
                    ) ) ,
                    
            ),
           
          ],
        ),
      ),
    );
  }
}