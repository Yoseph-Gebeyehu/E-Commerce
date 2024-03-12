part of 'auth_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {}

class AuthenticationErrorState extends AuthenticationState {
  final String errorMessage;

  AuthenticationErrorState({required this.errorMessage});
}
