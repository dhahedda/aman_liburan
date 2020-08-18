import 'dart:async';

mixin LoginValidator {
  StreamTransformer<String, String> emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      int len = email.length;
      if(len == 0){
        sink.addError("Email cannot be empty!");
      }else{
        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
        if(emailValid){
          sink.add(email);
        }else{
          sink.addError("Email is not valid!");
        }
      }
    }
  );

  StreamTransformer<String, String> passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink){
        if(password.length == 0){
          sink.addError("Password cannot be empty!");
        }else if(password.length < 6){
          sink.addError("Password length should be greater than 6 chars!");
        }else{
          sink.add(password);
        }
      }
  );

}