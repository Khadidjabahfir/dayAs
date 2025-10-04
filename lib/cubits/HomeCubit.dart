import 'package:dayas/models/UserModel.dart';
import 'package:dayas/models/customizedUserTask.dart';
import 'package:dayas/models/dailyHabitsModel.dart';
import 'package:dayas/states/HomeStates.dart';
import 'package:dayas/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Homecubit extends Cubit<Homestates> {
  Homecubit() : super (Homestates()); 
  void fetchInitialHome (String email ) async {
    emit(HomeStateInitial()) ; 
    try {
      emit(HomeStateLoading()); 
      await Future.delayed(Duration(seconds: 2)); 
      final user = UserModel(
      email: email,
      name: 'Sample User',
      birthday: '2000-01-01',
      profilePicUrl: '',
      nickName: 'SampleNick',
    );

    final habits = [
      dailyHabitsModel(habitName: 'Drink Water'),
      dailyHabitsModel(habitName: 'Read Book'),
      dailyHabitsModel(habitName: 'Exercise'),
    ];

    final tasks = [
      CustomizedUserTask(
        heroName: 'Hero',
        taskName: 'Sample Task 1',
        taskStart: '08:00',
        taskEnd: '09:00',
        taskColor: 'purple',
        isDone: false,
        subtasks: [],
      ),
      CustomizedUserTask(
        heroName: 'Hero',
        taskName: 'Sample Task 2',
        taskStart: '09:00',
        taskEnd: '10:00',
        taskColor: 'purple',
        isDone: true,
        subtasks: [],
      ),
    ];
    emit (HomeStateLoaded(user: user, habits: habits, tasks: tasks)); 
    }catch (e) {
      emit (HomeStateError(error: 'Error occured : $e')); 
    }

  }
}