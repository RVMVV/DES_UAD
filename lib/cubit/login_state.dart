part of 'login_cubit.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess();
}

final class LoginFailed extends LoginState {
  String message;
  LoginFailed(this.message);
}

final class LoginFailedDelay extends LoginState {
  String message;
  LoginFailedDelay(this.message);
}

final class LoginError extends LoginState {}
