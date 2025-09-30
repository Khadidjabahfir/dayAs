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
  Map<String, dynamic> toJson() {
    return {
      'heroName': heroName,
      'taskName': taskName,
      'taskStart': taskStart,
      'taskEnd': taskEnd,
      'taskColor': taskColor,
      'isDone': isDone,
      'subtasks': subtasks?.map((sub) => sub.toJson()).toList(),
    };
  }
  factory CustomizedUserTask.fromJson(Map<String, dynamic> json) {
    return CustomizedUserTask(
      heroName: json['heroName'] ?? '',
      taskName: json['taskName'] ?? '',
      taskStart: json['taskStart'] ?? '',
      taskEnd: json['taskEnd'] ?? '',
      taskColor: json['taskColor'] ?? 0,
      isDone: json['isDone'] ?? false,
      subtasks: (json['subtasks'] as List<dynamic>?)
          ?.map((e) => CustomizedUserTask.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}