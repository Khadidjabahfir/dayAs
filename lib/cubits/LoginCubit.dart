import 'package:dayas/states/LoginStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logincubit extends Cubit<Loginstates> {
  Logincubit() : super(LoginInitialState());

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(LoginErrorState("Email and password cannot be empty"));
      return;
    }

    emit(LoginLoadingState());

    try {
      await Future.delayed(Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", email);

      emit(LoginSuccessState(email)); 
    } catch (e) {
      emit(LoginErrorState("Login failed: $e"));
    }
  }
}


