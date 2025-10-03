abstract class Loginstates {}

class LoginInitialState extends Loginstates {}

class LoginLoadingState extends Loginstates {}

class LoginSuccessState extends Loginstates {
  final String email; 
  LoginSuccessState(this.email);
}

class LoginErrorState extends Loginstates {
  final String error;
  LoginErrorState(this.error);
}
