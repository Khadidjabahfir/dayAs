import 'package:dayas/models/heroModel.dart';
import 'package:dayas/states/chatStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Chatcubit extends Cubit<ChatStates> {
  Chatcubit() : super(ChatStates());
  void fetchRooms() async {
    emit(ChatStateLoading());
    try {
      await Future.delayed(Duration(seconds: 2)); 
      List<Heromodel> heroes = [
          // Heromodel(
          //   name: 'Olivia Rodrigo',
          //   role: 'Singer-Songwriter',
          //   imageUrl: 'assets/images/olivia.png',
          //   color: 'purple',
          // ),
          // Heromodel(
          //   name: 'SEVENTEEN',
          //   role: 'K-pop Group',
          //   imageUrl: 'assets/images/olivia.png',
          //   color: 'blue',
            
          // ),
        ];

      emit(ChatStateLoaded(herolist: heroes));
    } catch (e) {
      emit(ChatStateError(error: '$e'));
    }
  }
}