import 'package:dayas/screens/ExploreScreen.dart';
import 'package:dayas/screens/editTasksScreen.dart';
import 'package:dayas/widget/customUserTask.dart';
import 'package:dayas/widget/customsubtasks.dart';
import 'package:dayas/widget/standardTimeline.dart';
import 'package:flutter/material.dart';
import 'package:dayas/models/customizedUserTask.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dayas/cubits/CustomCubit.dart';

class CustomTaskWithSubtasks extends StatelessWidget {
  final CustomizedUserTask task;
  final int index;
  final int? parentIndex;
  final bool isSubtask;

  const CustomTaskWithSubtasks({
    super.key,
    required this.task,
    required this.index,
    this.parentIndex,
    this.isSubtask = false,
  });

  @override
  Widget build(BuildContext context) {
    final int subtasksCount = task.subtasks?.length ?? 0;
    final double lineHeight = subtasksCount * 60 + 60; 


    return Row(
      crossAxisAlignment: CrossAxisAlignment.center, 
      mainAxisAlignment: MainAxisAlignment.start, 
      children: [
         
        if (!isSubtask) ...[
          const SizedBox(width : 80),
          Padding(padding: const EdgeInsets.only(top : 20) , child: 
           getTimeline(getColorFromString(task.taskColor), lineHeight),
          ), 
          const SizedBox(width: 10), 
        ],

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              if (isSubtask)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: subCustomTasks(
                    taskName: task.taskName,
                    start: task.taskStart,
                    end: task.taskEnd,
                    color: getColorFromString(task.taskColor),
                    isDone: task.isDone,
                    onDoubleTap: () {
                      if (parentIndex != null) {
                        context
                            .read<CustomCubit>()
                            .toggleSubTaskDone(parentIndex!, index);
                      }
                    },
                    
                  ),
                )
              else
                CustomTask(
                  taskName: task.taskName,
                  start: task.taskStart,
                  end: task.taskEnd,
                  color: getColorFromString(task.taskColor),
                  isDone: task.isDone,
                  onDoubleTap: () {
                    context.read<CustomCubit>().toggleTaskDone(index);
                  },
                  onTap: (){
                      final cubit = context.read<CustomCubit>();
                      final stateTasks = cubit.state.tasks;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTasksScreen(
                            task: task       
                          ),
                        ),
                      );
                    },

                ),

              
              if (task.subtasks != null && task.subtasks!.isNotEmpty)
                ...task.subtasks!.asMap().entries.map((entry) {
                  final subIndex = entry.key;
                  final subTask = entry.value;

                  return CustomTaskWithSubtasks(
                    task: subTask,
                    index: subIndex,
                    parentIndex: index,
                    isSubtask: true,
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }
}