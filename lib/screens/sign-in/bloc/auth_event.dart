part of 'auth_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class SigninButtonEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SigninButtonEvent({
    required this.email,
    required this.password,
  });
}

class SignupButtonEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String userName;

  SignupButtonEvent({
    required this.email,
    required this.password,
    required this.userName,
  });
}

class ForgotPasswordEvent extends AuthenticationEvent {}
