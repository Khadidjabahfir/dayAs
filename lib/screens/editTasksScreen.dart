import 'package:dayas/models/customizedUserTask.dart';
import 'package:dayas/screens/ExploreScreen.dart';
import 'package:dayas/states/Customstates.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:dayas/widget/customization/customUserTask.dart';
import 'package:dayas/widget/customization/customizedUserTask.dart';
import 'package:dayas/widget/standardWidgets/standardButton.dart';
import 'package:dayas/widget/standardWidgets/standardInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dayas/cubits/CustomCubit.dart';
import 'package:dayas/widget/standardWidgets/standardSmallButton.dart';

class EditTasksScreen extends StatefulWidget {
  final CustomizedUserTask task;

  const EditTasksScreen({super.key, required this.task});

  @override
  State<EditTasksScreen> createState() => _EditTasksScreenState();
}

class _EditTasksScreenState extends State<EditTasksScreen> {
  late TextEditingController _tasknameController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _tasknameController = TextEditingController();
    _timeController = TextEditingController();
  }

  @override
  void dispose() {
    _tasknameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('DayAs', style: LineStyles.header),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<CustomCubit, CustomStates>(
            builder: (context, state) {
              final cubit = context.read<CustomCubit>();
              final taskIndex = state.tasks.indexWhere(
                (t) => t.taskName == widget.task.taskName,
              );
              final timeLeft = taskIndex != -1
                  ? cubit.timeLeftToPlan(taskIndex)
                  : 0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTask(
                    taskName: widget.task.taskName,
                    start: widget.task.taskStart,
                    end: widget.task.taskEnd,
                    color: getColorFromString(widget.task.taskColor),
                    isDone: widget.task.isDone,
                    onDoubleTap: () {},
                    onTap: () {},
                  ),
                  SizedBox(height: 8),
                  Text(
                    "You have $timeLeft minutes to plan",
                    style: LineStyles.subtitle.copyWith(
                      color: AppColors.lightGrey,
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Planned Tasks",
                      style: LineStyles.secodHeader.copyWith(
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: taskIndex != -1 &&
                            state.tasks[taskIndex].subtasks != null &&
                            state.tasks[taskIndex].subtasks!.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.tasks[taskIndex].subtasks!.length,
                            itemBuilder: (context, index) {
                              final subtask =
                                  state.tasks[taskIndex].subtasks![index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 30),
                                    Expanded(
                                      child: getUserTask(
                                        subtask.taskName,
                                        subtask.taskStart,
                                        subtask.taskEnd,
                                        subtask.isDone,
                                        getColorFromString(subtask.taskColor),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "No subtasks planned yet",
                              style: LineStyles.subtitle.copyWith(
                                color: AppColors.lightGrey,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Plan More",
                      style: LineStyles.secodHeader.copyWith(
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  GetInput(
                    "task",
                    "Task name",
                    controller: _tasknameController,
                  ),
                  SizedBox(height: 20),
                  GetInput(
                    "time",
                    "start - end",
                    controller: _timeController,
                  ),
                  SizedBox(height: 20),
                  getAsmallerbtn(
                    "Add task",
                    getColorFromString(widget.task.taskColor),
                    onTap: () {
                      final name = _tasknameController.text.trim();
                      final time = _timeController.text.trim();

                      if (taskIndex == -1) return;

                      if (name.isEmpty || time.isEmpty || !time.contains("-")) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Please enter a valid task name and time (e.g. 14:00-15:00)"),
                          ),
                        );
                        return;
                      }

                      final parts = time.split("-");
                      if (parts.length != 2) return;

                      final subTask = CustomizedUserTask(
                        heroName: widget.task.heroName,
                        taskName: name,
                        taskStart: parts[0].trim(),
                        taskEnd: parts[1].trim(),
                        taskColor: widget.task.taskColor,
                        isDone: false,
                        subtasks: [],
                      );

                      cubit.addSubTask(taskIndex, subTask);

                      if (cubit.state.tasks[taskIndex].subtasks!
                          .any((st) => st.taskName == name)) {
                        _tasknameController.clear();
                        _timeController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Subtask added successfully"),
                            backgroundColor: AppColors.purplePastel,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  getButton(
                    "Finalize",
                    getColorFromString(widget.task.taskColor),
                  ),
                ],
              );
            },
          ),
        ) 
    );
  }
}
