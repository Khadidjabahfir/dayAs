import 'package:dayas/cubits/HomeCubit.dart';
import 'package:dayas/models/UserModel.dart';
import 'package:dayas/models/customizedUserTask.dart';
import 'package:dayas/models/dailyHabitsModel.dart';
import 'package:dayas/screens/ExploreScreen.dart';
import 'package:dayas/screens/habits.dart';
import 'package:dayas/states/HomeStates.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:dayas/widget/customizedUserTask.dart';
import 'package:dayas/widget/habitWidget.dart';
import 'package:dayas/widget/navBarWidget.dart';
import 'package:dayas/widget/standardButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (_) => Homecubit(), 
    child : Scaffold(
      backgroundColor: Colors.white ,
      body : Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height : 30), 
            Image.asset('assets/images/home.png' , width :87 , height: 102, ) , 
            SizedBox(height: 10,),
            SizedBox(height : 30), 
            BlocBuilder<Homecubit , Homestates>
             (builder: (context, state) {
              if (state is HomeStateLoading){
                return CircularProgressIndicator(color : AppColors.purplePastel); 
              }else if (state is HomeStateError) {
                return Center (child : Text("An Error Occured :  " + state.error)); 
              }else if (state is HomeStateLoaded) {
                return getHomePageSections(context,state.user , state.habits , state.tasks ); 
              }
              return getHomePageSections( context , UserModel(email: "", name: "", birthday: "", profilePicUrl: "", nickName: "") , [] ,[]); 
            }), 
          ],
        )
      )
    )
    ); 
  }
}
Widget getHomePageSections(BuildContext context ,UserModel user, List<dailyHabitsModel> habits, List<CustomizedUserTask> tasks) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const SizedBox(height: 16),
        

          SizedBox(
            height: 120,
            child: habits.isEmpty
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("No Habits Found , Try Creating Some " , style : LineStyles.context.copyWith(color : AppColors.lightGrey , fontWeight: FontWeight.normal)), 
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>  AddHabits()),
                          );
                      },
                      child: Text(" Here " , style: LineStyles.act_subtitle.copyWith(color: AppColors.darkGrey , decoration: TextDecoration.underline))
                    )
                  ],
                )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      final habit = habits[index];
                      return GetHabit(habit.habitName, habit.isDone);
                    },
                  ),
          ),

          const SizedBox(height: 10),

       
          SizedBox(
            height: 250,
            child: tasks.isEmpty
                ?Center(child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("No Tasks Found  " , style : LineStyles.context.copyWith(color : AppColors.lightGrey , fontWeight: FontWeight.normal)), 
                    Text("Try To Explore Role Models List  " , style : LineStyles.context.copyWith(color : AppColors.lightGrey , fontWeight: FontWeight.normal)), 
                    SizedBox(height: 20,), 
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>  BottomBar(initialIndex : 1)), // like this navigate to the explore 
                          );
                      },
                      child: getButton("Explore", AppColors.purplePastel)
                    )
                  ],
                ))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return getUserTask(
                        task.taskName,
                        task.taskStart,
                        task.taskEnd,
                        task.isDone,
                        getColorFromString(task.taskColor),
                      );
                    },
                  ),
          ),
        ],
      ),
    ),
  );
}
