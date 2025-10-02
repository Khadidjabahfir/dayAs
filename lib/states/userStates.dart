import 'package:dayas/models/UserModel.dart';

class Userstates {}
class UserstatesInitial extends Userstates {

}
class UserstatesLoading extends Userstates {

}
class UserstatesLoaded extends Userstates {
  UserModel user ; 
  UserstatesLoaded ({required this.user }); 
}
class UserstatesError extends Userstates{
  String error ; 
  UserstatesError ({required this.error}); 
}