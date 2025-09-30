import 'dart:convert';
import 'package:dayas/models/customizedUserTask.dart';
import 'package:dayas/models/routineTaskModel.dart';
import 'package:dayas/states/Customstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomCubit extends Cubit<CustomStates> {
  CustomCubit() : super(CustomStates());

  static const String _tasksKey = 'customized_user_tasks';

 
  void loadTasks(String heroName, List<routineTasksModel> tasks) {
    final customizedTasks = tasks.map((task) {
      return CustomizedUserTask(
        heroName: heroName,
        taskName: task.taskName,
        taskStart: task.taskStart,
        taskEnd: task.taskEnd,
        taskColor: task.taskColor,
        isDone: false,
        subtasks: []
      );
    }).toList();
    savePlan(); 
    emit(state.copyWith(tasks: customizedTasks));
 
  }

 
  Future<void> loadSavedPlans() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? savedTasksJson = prefs.getString(_tasksKey);
      
      if (savedTasksJson != null && savedTasksJson.isNotEmpty) {
        final List<dynamic> decoded = json.decode(savedTasksJson);
        final tasks = decoded.map((taskJson) => 
          CustomizedUserTask.fromJson(taskJson)
        ).toList();
        
        emit(state.copyWith(tasks: tasks));
      }
    } catch (e) {
      print('Error loading saved plans: $e');
    }
  }

 
  Future<String?> addSubTask(int parentTaskIndex, CustomizedUserTask subTask) async {
    if (parentTaskIndex < 0 || parentTaskIndex >= state.tasks.length) {
      return "Invalid task index";
    }

    final updatedTasks = List<CustomizedUserTask>.from(state.tasks);
    final parentTask = updatedTasks[parentTaskIndex];

 
    if (!_isValidTimeFormat(subTask.taskStart) || !_isValidTimeFormat(subTask.taskEnd)) {
      return "Invalid time format. Use HH:MM format";
    }

  
    final subStart = _parseTime(subTask.taskStart);
    final subEnd = _parseTime(subTask.taskEnd);
    
    if (subStart >= subEnd) {
      return "Subtask start time must be before end time";
    }

  
    final parentStart = _parseTime(parentTask.taskStart);
    final parentEnd = _parseTime(parentTask.taskEnd);

    if (subStart < parentStart || subEnd > parentEnd) {
      return "Subtask must be within parent task time (${parentTask.taskStart} - ${parentTask.taskEnd})";
    }

   
    for (var existingSubtask in parentTask.subtasks ?? []) {
      final existingStart = _parseTime(existingSubtask.taskStart);
      final existingEnd = _parseTime(existingSubtask.taskEnd);

      if (_hasTimeOverlap(subStart, subEnd, existingStart, existingEnd)) {
        return "Subtask overlaps with '${existingSubtask.taskName}' (${existingSubtask.taskStart}-${existingSubtask.taskEnd})";
      }
    }

    
    final available = timeLeftToPlan(parentTaskIndex);
    final subTaskDuration = _getDuration(subTask.taskStart, subTask.taskEnd);

    if (subTaskDuration > available) {
      return "Not enough time left. Available: $available minutes, needed: $subTaskDuration minutes";
    }


    if (subTask.taskName.trim().isEmpty) {
      return "Subtask name cannot be empty";
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
    await savePlan(); 
    return null; 
  }

  Future<void> removeTask(CustomizedUserTask task) async {
    final updatedTasks = List<CustomizedUserTask>.from(state.tasks)..remove(task);
    emit(state.copyWith(tasks: updatedTasks));
    await savePlan(); 
  }

  Future<void> removeSubTask(int parentTaskIndex, int subTaskIndex) async {
    if (parentTaskIndex < 0 || parentTaskIndex >= state.tasks.length) return;

    final updatedTasks = List<CustomizedUserTask>.from(state.tasks);
    final parentTask = updatedTasks[parentTaskIndex];
    
    if (parentTask.subtasks == null || 
        subTaskIndex < 0 || 
        subTaskIndex >= parentTask.subtasks!.length) return;

    final updatedSubtasks = List<CustomizedUserTask>.from(parentTask.subtasks!)
      ..removeAt(subTaskIndex);

    updatedTasks[parentTaskIndex] = CustomizedUserTask(
      heroName: parentTask.heroName,
      taskName: parentTask.taskName,
      taskStart: parentTask.taskStart,
      taskEnd: parentTask.taskEnd,
      taskColor: parentTask.taskColor,
      subtasks: updatedSubtasks,
    )..isDone = parentTask.isDone;

    emit(state.copyWith(tasks: updatedTasks));
    await savePlan(); 
  }

  Future<void> toggleTaskDone(int index) async {
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
    await savePlan(); 
  }

  Future<void> toggleSubTaskDone(int taskIndex, int subTaskIndex) async {
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
    await savePlan(); 
  }

  void setTasks(List<CustomizedUserTask> tasks) {
    emit(state.copyWith(tasks: tasks));
    savePlan(); 
  }


  Future<void> savePlan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = state.tasks.map((task) => task.toJson()).toList();
      final jsonString = json.encode(tasksJson);
      await prefs.setString(_tasksKey, jsonString);
      print('Plan saved successfully');
    } catch (e) {
      print('Error saving plan: $e');
    }
  }


  Future<void> clearSavedPlans() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tasksKey);
      emit(state.copyWith(tasks: []));
      print('Saved plans cleared');
    } catch (e) {
      print('Error clearing saved plans: $e');
    }
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
      final startMinutes = _parseTime(start);
      final endMinutes = _parseTime(end);

      return (endMinutes - startMinutes).clamp(0, 1440);
    } catch (e) {
      return 0;
    }
  }


  int _parseTime(String time) {
    final parts = time.split(":").map(int.parse).toList();
    return parts[0] * 60 + parts[1];
  }


  bool _isValidTimeFormat(String time) {
    final regex = RegExp(r'^\d{1,2}:\d{2}$');
    if (!regex.hasMatch(time)) return false;

    try {
      final parts = time.split(":");
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      return hour >= 0 && hour < 24 && minute >= 0 && minute < 60;
    } catch (e) {
      return false;
    }
  }


  bool _hasTimeOverlap(int start1, int end1, int start2, int end2) {
    return !(end1 <= start2 || end2 <= start1);
  }


  List<CustomizedUserTask> getSortedSubtasks(int taskIndex) {
    if (taskIndex < 0 || taskIndex >= state.tasks.length) return [];
    
    final subtasks = state.tasks[taskIndex].subtasks ?? [];
    final sorted = List<CustomizedUserTask>.from(subtasks);
    
    sorted.sort((a, b) => _parseTime(a.taskStart).compareTo(_parseTime(b.taskStart)));
    
    return sorted;
  }

  int getTotalPlannedTime(int taskIndex) {
    if (taskIndex < 0 || taskIndex >= state.tasks.length) return 0;
    
    int total = 0;
    for (var sub in state.tasks[taskIndex].subtasks ?? []) {
      total += _getDuration(sub.taskStart, sub.taskEnd);
    }
    
    return total;
  }


  double getPlannedPercentage(int taskIndex) {
    if (taskIndex < 0 || taskIndex >= state.tasks.length) return 0.0;
    
    final task = state.tasks[taskIndex];
    final total = _getDuration(task.taskStart, task.taskEnd);
    
    if (total == 0) return 0.0;
    
    final planned = getTotalPlannedTime(taskIndex);
    return (planned / total * 100).clamp(0.0, 100.0);
  }
}