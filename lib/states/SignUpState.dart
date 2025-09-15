class Signupstate {}
class SignupstateInitial extends Signupstate {

}
class SignupstateLoading extends Signupstate {

}
class SignupstateLoaded extends Signupstate {

}
class SignupstateError extends Signupstate {
  String? error ; 
  SignupstateError(this.error); 
}