part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SigninToggled extends SigninEvent {}

class SignupToggled extends SigninEvent {}

class SignupConfirmToggled extends SigninEvent {}

class SigninPressed extends SigninEvent {}

class SignupPressed extends SigninEvent {}

class ForgotPasswordPressed extends SigninEvent {}
