class CustomizedUserTask {
  String taskName;
  String taskStart;
  String taskEnd;
  String taskColor;
  String heroName ; 
  bool isDone;
  List<CustomizedUserTask>? subtasks; 

  CustomizedUserTask({
    required this.heroName, 
    required this.taskName,
    required this.taskStart,
    required this.taskEnd,
    required this.taskColor,
    this.isDone = false,
    this.subtasks,
  });
}