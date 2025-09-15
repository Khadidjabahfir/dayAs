import 'package:dayas/states/LoginStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Logincubit extends Cubit<Loginstates> {
  Logincubit() : super(LoginInitialState());
  void login(String email, String password) async {
    emit(LoginLoadingState());
    try {
      await Future.delayed(Duration(seconds: 2));
      emit(LoginSuccessState());
    } catch (e) {
      emit(loginErrorState('$e'));
    }
  }
}