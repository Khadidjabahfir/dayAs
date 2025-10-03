import 'package:dayas/models/heroModel.dart';

class ChatStates {}
class ChatStateInitial extends ChatStates {

}
class ChatStateLoading extends ChatStates {

}
class ChatStateLoaded extends ChatStates {
   List<Heromodel> herolist ; 
   ChatStateLoaded({required this.herolist}); 
}
class ChatStateError extends ChatStates {
  String error ; 
  ChatStateError ({required this.error }); 
}