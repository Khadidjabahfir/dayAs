import 'package:dayas/models/customizedUserTask.dart';
import 'package:dayas/models/routineTaskModel.dart';
import 'package:dayas/states/Customstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCubit extends Cubit<CustomStates> {
  CustomCubit() : super(CustomStates());

  void loadTasks(String heroName, List<routineTasksModel> tasks) {
    final customizedTasks = tasks.map((task) {
      return CustomizedUserTask(
        heroName: heroName,
        taskName: task.taskName,
        taskStart: task.taskStart,
        taskEnd: task.taskEnd,
        taskColor: task.taskColor,
        isDone: false,
        subtasks: [
          CustomizedUserTask(
            heroName: heroName,
            taskName: "Cleaning",
            taskStart: "2:00",
            taskEnd: "3:00",
            taskColor: "purple",
          )
        ],
      );
    }).toList();

    emit(state.copyWith(tasks: customizedTasks));
  }

  void addSubTask(int parentTaskIndex, CustomizedUserTask subTask) {
    if (parentTaskIndex < 0 || parentTaskIndex >= state.tasks.length) return;

    final updatedTasks = List<CustomizedUserTask>.from(state.tasks);
    final parentTask = updatedTasks[parentTaskIndex];

    
    final available = timeLeftToPlan(parentTaskIndex);
    final subTaskDuration = _getDuration(subTask.taskStart, subTask.taskEnd);

   
    if (subTaskDuration > available) {
      
      print("Not enough time left for this subtask");
      return;
    }

   
    final updatedSubtasks = List<CustomizedUserTask>.from(parentTask.subtasks ?? [])
      ..add(subTask);

    updatedTasks[parentTaskIndex] = CustomizedUserTask(
      heroName: parentTask.heroName,
      taskName: parentTask.taskName,
      taskStart: parentTask.taskStart,
      taskEnd: parentTask.taskEnd,
      taskColor: parentTask.taskColor,
      subtasks: updatedSubtasks,
    )..isDone = parentTask.isDone;

    emit(state.copyWith(tasks: updatedTasks));
  }


  void removeTask(CustomizedUserTask task) {
    final updatedTasks = List<CustomizedUserTask>.from(state.tasks)..remove(task);
    emit(state.copyWith(tasks: updatedTasks));
  }

  void toggleTaskDone(int index) {
    final updatedTasks = List<CustomizedUserTask>.from(state.tasks);
    final current = updatedTasks[index];
    updatedTasks[index] = CustomizedUserTask(
      heroName: current.heroName,
      taskName: current.taskName,
      taskStart: current.taskStart,
      taskEnd: current.taskEnd,
      taskColor: current.taskColor,
      subtasks: current.subtasks,
    )..isDone = !(current.isDone ?? false);

    emit(state.copyWith(tasks: updatedTasks));
  }

  void toggleSubTaskDone(int taskIndex, int subTaskIndex) {
    final updatedTasks = List<CustomizedUserTask>.from(state.tasks);

    if (taskIndex < 0 || taskIndex >= updatedTasks.length) return;

    final parentTask = updatedTasks[taskIndex];
    final updatedSubtasks = List<CustomizedUserTask>.from(parentTask.subtasks ?? []);

    if (subTaskIndex < 0 || subTaskIndex >= updatedSubtasks.length) return;

   
    final currentSubtask = updatedSubtasks[subTaskIndex];
    updatedSubtasks[subTaskIndex] = CustomizedUserTask(
      heroName: currentSubtask.heroName,
      taskName: currentSubtask.taskName,
      taskStart: currentSubtask.taskStart,
      taskEnd: currentSubtask.taskEnd,
      taskColor: currentSubtask.taskColor,
      subtasks: currentSubtask.subtasks,
    )..isDone = !(currentSubtask.isDone ?? false);

   
    final allSubtasksDone = updatedSubtasks.every((st) => st.isDone == true);


    updatedTasks[taskIndex] = CustomizedUserTask(
      heroName: parentTask.heroName,
      taskName: parentTask.taskName,
      taskStart: parentTask.taskStart,
      taskEnd: parentTask.taskEnd,
      taskColor: parentTask.taskColor,
      subtasks: updatedSubtasks,
    )..isDone = allSubtasksDone;

    emit(state.copyWith(tasks: updatedTasks));
  }

  void setTasks(List<CustomizedUserTask> tasks) {
    emit(state.copyWith(tasks: tasks));
  }

  Future<void> savePlan() async {
    // TODO: implement API or local storage saving here
  }

  
  int timeLeftToPlan(int taskIndex) {
    if (taskIndex < 0 || taskIndex >= state.tasks.length) return 0;

    final task = state.tasks[taskIndex];
    final totalTaskDuration = _getDuration(task.taskStart, task.taskEnd);

    
    int usedBySubtasks = 0;
    for (var sub in task.subtasks ?? []) {
      usedBySubtasks += _getDuration(sub.taskStart, sub.taskEnd);
    }

    final left = totalTaskDuration - usedBySubtasks;
    return left > 0 ? left : 0;
  }
  int _getDuration(String start, String end) {
    if (start.isEmpty || end.isEmpty) return 0;
    try {
      final startParts = start.split(":").map(int.parse).toList();
      final endParts = end.split(":").map(int.parse).toList();

      final startMinutes = startParts[0] * 60 + startParts[1];
      final endMinutes = endParts[0] * 60 + endParts[1];

      return (endMinutes - startMinutes).clamp(0, 1440);
    } catch (e) {
      return 0;
    }
  }
  
  
}
