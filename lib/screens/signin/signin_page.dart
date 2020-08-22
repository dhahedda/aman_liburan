import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aman_liburan/blocs/signin/signin_bloc.dart';
import 'package:aman_liburan/screens/signin/google_signin.dart';
import 'package:aman_liburan/utilities/bubble_indication_painter.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<SigninBloc>(
        create: (context) => SigninBloc(),
        child: SigninScreen(),
      );
}

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final myFocusNodeEmailSignin = FocusNode();
  final myFocusNodePasswordSignin = FocusNode();

  final myFocusNodePassword = FocusNode();
  final myFocusNodeEmail = FocusNode();
  final myFocusNodeFirstName = FocusNode();
  final myFocusNodeLastName = FocusNode();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  SigninBloc _signinBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state.signinStatus == SigninStatus.done) {
          Navigator.of(context).pushReplacementNamed('/app-base-configuration');
        }
      },
      builder: (context, state) {
        Widget _buildMenuBar(BuildContext context) {
          return Container(
            width: 300.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Color(0x552B2B2B),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: CustomPaint(
              painter: TabIndicationPainter(pageController: _pageController),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: _onSignInButtonPress,
                      child: Text(
                        "Existing",
                        style: TextStyle(color: left, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
                      ),
                    ),
                  ),
                  //Container(height: 33.0, width: 1.0, color: Colors.white),
                  Expanded(
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: _onSignUpButtonPress,
                      child: Text(
                        "New",
                        style: TextStyle(color: right, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        Widget _buildSignIn(BuildContext context) {
          return Container(
            padding: EdgeInsets.only(top: 23.0),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Card(
                      elevation: 2.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        width: 300.0,
                        height: 190.0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                              child: TextField(
                                focusNode: myFocusNodeEmailSignin,
                                controller: state.signinEmailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.envelope,
                                    color: Colors.black,
                                    size: 22.0,
                                  ),
                                  hintText: "Email Address",
                                  hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                              child: TextField(
                                focusNode: myFocusNodePasswordSignin,
                                controller: state.signinPasswordController,
                                obscureText: state.obscureTextSignin,
                                style: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.lock,
                                    size: 22.0,
                                    color: Colors.black,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _signinBloc.add(SigninToggled());
                                    },
                                    child: Icon(
                                      state.obscureTextSignin ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 170.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Theme.Colors.turqoiseLight,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: Theme.Colors.turqoiseDark,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        gradient: LinearGradient(
                            colors: [Theme.Colors.turqoiseDark, Theme.Colors.turqoiseLight],
                            begin: const FractionalOffset(0.2, 0.2),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.signinGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: () {
                          showInSnackBar("Signin button pressed");
                          _signinBloc.add(SigninPressed());
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => App()));
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                      onPressed: () {
                        // Entah
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => App()));
                        // WS
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
                        _signinBloc.add(ForgotPasswordPressed());
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(decoration: TextDecoration.underline, color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansMedium"),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.white10,
                                Colors.white,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: 100.0,
                        height: 1.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Or",
                          style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansMedium"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white10,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: 100.0,
                        height: 1.0,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, right: 40.0),
                      child: GestureDetector(
                        onTap: () {
                          showInSnackBar("Facebook button pressed");

                          String clientId = '936813033337153';
                          String redirectUrl = 'https://www.facebook.com/connect/login_success.html';
                          loginWithFacebook() async {
                            String result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomWebView(
                                        selectedUrl:
                                            'https://www.facebook.com/dialog/oauth?client_id=$clientId&redirect_uri=$redirectUrl&response_type=token&scope=email,public_profile,',
                                      ),
                                  maintainState: true),
                            );
                            print(result);
                          }

                          loginWithFacebook();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            FontAwesomeIcons.facebookF,
                            color: Color(0xFF0084ff),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          showInSnackBar("Google button pressed");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleSignInDemo()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            FontAwesomeIcons.google,
                            color: Color(0xFF0084ff),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        Widget _buildSignUp(BuildContext context) {
          return Container(
            padding: EdgeInsets.only(top: 23.0),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Card(
                      elevation: 2.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        width: 300.0,
                        height: 360.0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: TextField(
                                      focusNode: myFocusNodeFirstName,
                                      controller: state.signupFirstNameController,
                                      keyboardType: TextInputType.text,
                                      textCapitalization: TextCapitalization.words,
                                      style: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0, color: Colors.black),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(
                                          FontAwesomeIcons.user,
                                          color: Colors.black,
                                        ),
                                        hintText: "First Name",
                                        hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      focusNode: myFocusNodeLastName,
                                      controller: state.signupLastNameController,
                                      keyboardType: TextInputType.text,
                                      textCapitalization: TextCapitalization.words,
                                      style: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0, color: Colors.black),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Last Name",
                                        hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                              child: TextField(
                                focusNode: myFocusNodeEmail,
                                controller: state.signupEmailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.envelope,
                                    color: Colors.black,
                                  ),
                                  hintText: "Email Address",
                                  hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                              child: TextField(
                                focusNode: myFocusNodePassword,
                                controller: state.signupPasswordController,
                                obscureText: state.obscureTextSignup,
                                style: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.lock,
                                    color: Colors.black,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _signinBloc.add(SignupToggled());
                                    },
                                    child: Icon(
                                      state.obscureTextSignup ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                              child: TextField(
                                controller: state.signupConfirmPasswordController,
                                obscureText: state.obscureTextSignupConfirm,
                                style: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.lock,
                                    color: Colors.black,
                                  ),
                                  hintText: "Confirmation",
                                  hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _signinBloc.add(SignupConfirmToggled());
                                    },
                                    child: Icon(
                                      state.obscureTextSignupConfirm ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 340.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Theme.Colors.turqoiseLight,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: Theme.Colors.turqoiseDark,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        gradient: LinearGradient(
                            colors: [Theme.Colors.turqoiseDark, Theme.Colors.turqoiseLight],
                            begin: const FractionalOffset(0.2, 0.2),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.signinGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: () {
                          showInSnackBar("SignUp button pressed");
                          _signinBloc.add(SigninPressed());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        return Scaffold(
          key: _scaffoldKey,
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return true;
            },
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height >= 775.0 ? MediaQuery.of(context).size.height : 775.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Theme.Colors.turqoiseLighter, Theme.Colors.turqoiseDark],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 75.0),
                      child: Image(width: 250.0, height: 191.0, fit: BoxFit.fill, image: AssetImage('assets/images/signin_logo.png')),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: _buildMenuBar(context),
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (i) {
                          if (i == 0) {
                            setState(() {
                              right = Colors.white;
                              left = Colors.black;
                            });
                          } else if (i == 1) {
                            setState(() {
                              right = Colors.black;
                              left = Colors.white;
                            });
                          }
                        },
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildSignIn(context),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildSignUp(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeFirstName.dispose();
    myFocusNodeLastName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _signinBloc = BlocProvider.of<SigninBloc>(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}

class CustomWebView extends StatefulWidget {
  final String selectedUrl;

  CustomWebView({this.selectedUrl});

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.contains("#access_token")) {
        succeed(url);
      }

      if (url.contains("https://www.facebook.com/connect/login_success.html?error=access_denied&error_code=200&error_description=Permissions+error&error_reason=user_denied")) {
        denied();
      }
    });
  }

  denied() {
    Navigator.pop(context);
  }

  succeed(String url) {
    var params = url.split("access_token=");

    var endparam = params[1].split("&");

    Navigator.pop(context, endparam[0]);
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: widget.selectedUrl,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(66, 103, 178, 1),
          title: Text("Facebook login"),
        ));
  }
}
