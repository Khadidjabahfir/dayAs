import 'package:dayas/models/customizedUserTask.dart';
import 'package:dayas/screens/ExploreScreen.dart';
import 'package:dayas/states/Customstates.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:dayas/widget/customUserTask.dart';
import 'package:dayas/widget/customizedUserTask.dart';
import 'package:dayas/widget/standardButton.dart';
import 'package:dayas/widget/standardInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dayas/cubits/CustomCubit.dart';

class EditTasksScreen extends StatelessWidget {
  final CustomizedUserTask task;
  
  const EditTasksScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController _tasknameController = TextEditingController(); 
    TextEditingController _timeController = TextEditingController(); 
    
    return BlocProvider(
      create: (_) {
        final cubit = CustomCubit(); 
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('DayAs', style: LineStyles.header),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Center(
          child : Padding(padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<CustomCubit, CustomStates>(
            builder: (context, state) {
              final cubit = context.read<CustomCubit>();
              final taskIndex =
                  state.tasks.indexWhere((t) => t.taskName == task.taskName);

              final timeLeft = taskIndex != -1
                  ? cubit.timeLeftToPlan(taskIndex)
                  : 0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTask(
                    taskName: task.taskName,
                    start: task.taskStart,
                    end: task.taskEnd,
                    color: getColorFromString(task.taskColor),
                    isDone: task.isDone,
                    onDoubleTap: () {},
                    onTap: () {},
                  ),
                  SizedBox(height : 8) , 
                  Text(
                    "You have $timeLeft minutes to plan",
                    style: LineStyles.subtitle.copyWith(
                      color: AppColors.lightGrey,
                    ),
                  ),
                  SizedBox(height: 20,) , 
                  Container(
                    width: double.infinity, 
                    child : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width : 20) , 
                        Text("Planned Tasks" , style : LineStyles.secodHeader.copyWith(color : AppColors.darkGrey , fontWeight: FontWeight.normal))
                      ],
                    )
                  ),
                  SizedBox(height : 10) ,  
                  Expanded(
                    child: ListView.builder(
                      itemCount: taskIndex != -1 ? state.tasks[taskIndex].subtasks?.length ?? 0 : 0,
                      itemBuilder: (context, index) {
                        final subtask = state.tasks[taskIndex].subtasks![index];
                        return Row(
                          children: [
                          SizedBox(width : 30) , 
                          getUserTask (subtask.taskName , 
                            subtask.taskStart ,
                            subtask.taskEnd ,
                            subtask.isDone ,
                            getColorFromString(subtask.taskColor)
                          ) 
                          ],
                        )
                        ; 
                      },
                    ),
                  ), 
                  SizedBox(height : 10) , 
                  Container(
                    width: double.infinity, 
                    child : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width : 20) , 
                        Text("Plan More" , style : LineStyles.secodHeader.copyWith(color : AppColors.darkGrey , fontWeight: FontWeight.normal))
                      ],
                    )
                  ),
                  GetInput("task", "Task name " , controller: _tasknameController) , 
                  SizedBox(height: 20 ) , 
                  GetInput("time", "start - end " , controller: _timeController) , 
                  SizedBox(height: 20 ) , 
                  getAsmallerbtn("Add task", getColorFromString(task.taskColor) , 
                  onTap: () {
                    final cubit = context.read<CustomCubit>();
                    final taskIndex = cubit.state.tasks.indexWhere((t) => t.taskName == task.taskName);

                    if (taskIndex == -1) return;

                    final name = _tasknameController.text.trim();
                    final time = _timeController.text.trim();

                    if (name.isEmpty || time.isEmpty || !time.contains("-")) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter a valid task name and time (e.g. 14:00-15:00)")),
                      );
                      return;
                    }

                    final parts = time.split("-");
                    if (parts.length != 2) return;

                    final start = parts[0].trim();
                    final end = parts[1].trim();

                    final subTask = CustomizedUserTask(
                      heroName: task.heroName,
                      taskName: name,
                      taskStart: start,
                      taskEnd: end,
                      taskColor: task.taskColor,
                      isDone: false,
                      subtasks: [],
                    );

                  
                    cubit.addSubTask(taskIndex, subTask);

                    _tasknameController.clear();
                    _timeController.clear();
                  },
                  ) , 
                  SizedBox(height: 20,) , 
                  getButton("Finalize", getColorFromString(task.taskColor)) , 
                ],
              );
            },
          ),
        ),
      ),
    )
    );
  }
}
