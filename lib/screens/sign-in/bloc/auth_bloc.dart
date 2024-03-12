import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {});
    on<SigninButtonEvent>((event, emit) async {
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        print('sign in event');
      }
    });
    on<SignupButtonEvent>((event, emit) async {
      if (event.userName.isNotEmpty &&
          event.email.isNotEmpty &&
          event.password.isNotEmpty) {
        print('sign up up event');
      }
    });
    on<ForgotPasswordEvent>((event, emit) async {
      print('Forgot password');
    });
  }
}
