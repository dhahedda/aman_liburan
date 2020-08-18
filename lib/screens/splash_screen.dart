import 'dart:async';

import 'package:flutter/material.dart';
import 'package:aman_liburan/components/data_session.dart';

class SplahScreen extends StatefulWidget {
  @override
  _SplahScreenState createState() => _SplahScreenState();
}

enum AuthStatus{
  notSignedIn,
  SignedIn,
}

class _SplahScreenState extends State<SplahScreen> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  void navigationPage() {
    switch (authStatus){
      case AuthStatus.SignedIn:
        Navigator.of(context).pushReplacementNamed('/app-base-configuration');
        break;
      case AuthStatus.notSignedIn:
        // Navigator.of(context).pushReplacementNamed('/login-page');
        Navigator.of(context).pushReplacementNamed('/app-base-configuration');
        break;
    }
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    DataSession dataSession = DataSession();
    dataSession.getStatusLogin().then((isLogin){
      if(isLogin){
        setState(() {
          authStatus = AuthStatus.SignedIn;
        });
      }else{
        setState(() {
          authStatus = AuthStatus.notSignedIn;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    startTime();
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/splash_image.png'),
      ),
    );
  }
}
