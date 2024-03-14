import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    snackBar(String message, Color? colors) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: colors,
        fontSize: 20.0,
      );
    }

    on<AuthenticationEvent>((event, emit) async {});

    on<SigninButtonEvent>((event, emit) async {
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        emit(AuthenticationLoadingState());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(AuthenticationSuccessState());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            snackBar(
              'The password is wrong',
              Colors.red,
            );
          } else if (e.code == 'invalid-email') {
            snackBar(
              'The email is invalid',
              Colors.red,
            );
          } else if (e.code == 'invalid-credential') {
            snackBar(
              'The email or password is wrong',
              Colors.red,
            );
          }
        }
      } else {
        snackBar(
          'The password or email is empty',
          Colors.red,
        );
      }
    });

    on<SignupButtonEvent>((event, emit) async {
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          snackBar(
            'Sign up successfuly',
            Colors.green,
          );
          emit(AuthenticationSuccessState());
        } catch (error) {
          if (error is FirebaseAuthException) {
            switch (error.code) {
              case 'weak-password':
                snackBar(
                  'Password should be at least 6 characters',
                  Colors.red,
                );
                break;
              case 'invalid-email':
                snackBar(
                  'The email address is not correct',
                  Colors.red,
                );
                break;
              case 'email-already-in-use':
                snackBar(
                  'The email address is already in use by another account',
                  Colors.red,
                );
                break;
              default:
                snackBar(
                  'An unexpected error occurred. Please try again later.',
                  Colors.red,
                );
            }
          } else {
            snackBar(
              'An unexpected error occurred. Please try again later.',
              Colors.red,
            );
          }
        }
      } else {
        snackBar(
          'The password or email is empty',
          Colors.red,
        );
      }
    });

    on<ForgotPasswordEvent>((event, emit) async {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: event.email);
        snackBar(
          'Password reset email sent successfully',
          Colors.green,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'missing-email') {
          snackBar(
            'An email address must be provided',
            Colors.red,
          );
        } else if (e.code == 'invalid-email') {
          snackBar(
            'The email address is badly formatted',
            Colors.red,
          );
        } else {
          snackBar(
            'An unexpected error occurred. Please try again later.',
            Colors.red,
          );
        }
      } catch (e) {
        snackBar(
          'An unexpected error occurred. Please try again later.',
          Colors.red,
        );
      }
    });
  }
}
