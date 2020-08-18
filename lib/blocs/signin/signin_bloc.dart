import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:aman_liburan/components/data_session.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/signin_repository.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  @override
  SigninState get initialState => SigninState.initial();

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if (event is SigninToggled) {
      yield state.copyWith(obscureTextSignin: !state.obscureTextSignin);
    }
    if (event is SignupToggled) {
      yield state.copyWith(obscureTextSignup: !state.obscureTextSignup);
    }
    if (event is SignupConfirmToggled) {
      yield state.copyWith(obscureTextSignupConfirm: !state.obscureTextSignupConfirm);
    }
    if (event is ForgotPasswordPressed) {
      yield state.copyWith(
        signinEmailController: TextEditingController(text: 'uzzysteam@gmail.com'),
        signinPasswordController: TextEditingController(text: 'GoDummy2020'),
      );
    }
    if (event is SigninPressed) {
      GlobalResponse response = await SigninRepository().postSignin(
          params: SigninParam(
        email: state.signinEmailController.text,
        password: state.signinPasswordController.text,
      ));
      if (response.status == 'Success') {
        DataSession().setEmail(state.signinEmailController.text);
        DataSession().setPassword(state.signinPasswordController.text);
        DataSession().setUsername('${response.data.user.firstName} ${response.data.user.lastName}');
        DataSession().setStatusLogin(true);
        DataSession().setUserId(response.data.user.id);

        yield state.copyWith(signinStatus: SigninStatus.done);
      } else {
        yield state.copyWith(signinStatus: SigninStatus.failed);
      }
    }
    if (event is SignupPressed) {}
  }
}
