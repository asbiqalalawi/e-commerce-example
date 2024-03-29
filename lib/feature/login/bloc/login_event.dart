part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginWithUsernameEvent extends LoginEvent {
  final String username;
  final String password;

  LoginWithUsernameEvent({required this.username, required this.password});
}
