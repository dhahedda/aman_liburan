import 'dart:async';

import 'package:aman_liburan/components/data_session.dart';
import 'package:aman_liburan/models/user.dart';
import 'package:aman_liburan/repositories/account_repository.dart';
import 'package:aman_liburan/services/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is LoginButtonPressed) {
      yield*_loginButtonPressed(event);
    }
  }

  Stream<LoginState> _loginButtonPressed(LoginButtonPressed event) async* {
    yield LoginLoading();
    UserServices _userService = UserServices();
    if(event.email == "") {
      yield LoginFailure(errorMsg: 'Please fill the username field');
    } else if(event.password.length < 6) {
      yield LoginFailure(errorMsg: 'Password length must be at least 6 characters');
    } else {
      var response;
      try {
        response = await _userService.signIn(
          event.email,
          event.password,
        );

        if(!response) {
          yield LoginFailure(errorMsg: response['data']);
        } else {
          User user; 
          AccountRepository _accountRepository = AccountRepository();
          Map<String, dynamic> userMap = await _accountRepository.getAccountProfile(params: null);
          user = User.fromMap(userMap);

          DataSession().setUserRole(user.role);
          
          yield LoginSuccess(
              user: user
          );
        }
        
      } catch (error) {
        yield LoginFailure(errorMsg: error.toString());
      }
          
    }
  }
}
