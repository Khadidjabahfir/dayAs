import 'package:dayas/models/UserModel.dart';
import 'package:dayas/models/customizedUserTask.dart';
import 'package:dayas/models/dailyHabitsModel.dart';


class Homestates {}
class HomeStateInitial extends Homestates {

}
class HomeStateLoading extends Homestates {

}
class HomeStateLoaded extends Homestates {
  UserModel user ; 
  List<dailyHabitsModel> habits ; 
  List<CustomizedUserTask> tasks ; 
  HomeStateLoaded({required this.user , required this.habits , required this.tasks}); 
}
class HomeStateError extends Homestates {
  String error ; 
  HomeStateError ({required this.error }); 
}