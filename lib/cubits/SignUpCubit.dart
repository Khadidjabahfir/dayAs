import 'package:dayas/states/SignUpState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Signupcubit extends Cubit<Signupstate> {
  Signupcubit() :super (SignupstateInitial()); 
  void  signUp (String email , String password , String verify_password) async{
    emit(SignupstateLoading()); 
    try {
      await Future.delayed(Duration(seconds: 2));
      emit(SignupstateLoaded()); 
    }catch(e){
      emit(SignupstateError('$e')); 
    }
  }
}