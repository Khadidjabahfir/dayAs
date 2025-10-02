import 'package:dayas/models/UserModel.dart';
import 'package:dayas/states/userStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Usercubit extends Cubit<Userstates> {
  Usercubit() : super(Userstates());

  void fetchUser(String email) async {
    emit(UserstatesLoading());
    try {
      await Future.delayed(Duration(seconds: 2)); 

      
      final user =UserModel(email: email, name: "test", birthday: "", profilePicUrl: "", nickName: ""); 
    

      emit(UserstatesLoaded(user: user));
    } catch (e) {
      emit(UserstatesError(error: e.toString()));
    }
  }
}
