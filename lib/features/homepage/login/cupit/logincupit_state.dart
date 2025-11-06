abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginWithEmailLoading extends LoginState {}

class LoginWithEmailSuccess extends LoginState {}

class LoginWithEmailfailed extends LoginState {
  final String error;
  LoginWithEmailfailed({required this.error});
}

class LoginWithGoogleLoading extends LoginState {}

class LoginWithGoogleSuccess extends LoginState {}

class LoginWithGooglefailed extends LoginState {
  final String error;
  LoginWithGooglefailed({required this.error});
}

class LogoutLoading extends LoginState {}

class LogoutSuccess extends LoginState {}

class Logoutfailed extends LoginState {
  final String error;

  Logoutfailed({required this.error});
}

class LoginCancelled extends LoginState {}
