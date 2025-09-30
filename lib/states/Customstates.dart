import 'package:dayas/models/customizedUserTask.dart';

class CustomStates {
  final List<CustomizedUserTask> tasks;

  CustomStates({this.tasks = const []});

  CustomStates copyWith({List<CustomizedUserTask>? tasks}) {
    return CustomStates(
      tasks: tasks ?? this.tasks,
    );
  }
}
