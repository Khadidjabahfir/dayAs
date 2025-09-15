class Loginstates {}
class LoginInitialState extends Loginstates {}
class LoginLoadingState extends Loginstates {}
class LoginSuccessState extends Loginstates {}
class loginErrorState extends Loginstates {
  final String error;
  loginErrorState(this.error);
}