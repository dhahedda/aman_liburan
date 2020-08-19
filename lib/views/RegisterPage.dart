import 'package:aman_liburan/services/Screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: unused_import
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import 'LoginPage.dart';
import 'RegisterPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  static const route = '/login';
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullname = TextEditingController();
  TextEditingController _user = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _domicile = TextEditingController();
  void dispose() {
    _fullname.clear();
    _user.clear();
    _password.clear();
    _domicile.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return SafeArea(
      child: Container(
          color: Colors.blue,
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.white,
            body: Center(
              child: KeyboardAvoider(
                autoScroll: true,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: Screen.blockY * 10),
                      width: Screen.x,
                      child: SvgPicture.asset(
                        'images/waves_blue.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Screen.blockY * 10),
                      width: Screen.x,
                      child: SvgPicture.asset(
                        'images/waves_green.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Screen.blockY * 20),
                      height: Screen.y,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Center(
                          child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '\nDaftar\n',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Screen.blockX * 6),
                                  ),
                                  _Form(
                                    hint: 'Nama Lengkap',
                                    controller: _fullname,
                                  ),
                                  _Form(
                                    hint: "Username",
                                    controller: _user,
                                  ),
                                  _Form(
                                    hint: "Password",
                                    controller: _password,
                                  ),
                                  _Form(
                                    hint: "Domisili",
                                    controller: _domicile,
                                  ),
                                  CustomButton(
                                    color: CustomColor().primary,
                                    fontColor: Colors.white,
                                    function: () => print('register'),
                                    hint: 'REGISTER',
                                    width: Screen.blockX * 80,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: '\nSudah punya akun? ',
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: Screen.blockX * 5),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Login',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => Get.back(),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ))),
                    ),
                    Container(
                      width: Screen.blockX * 25,
                      child: Image.asset('images/ic.png'),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class _Form extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  const _Form({Key key, this.hint, this.controller}) : super(key: key);
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  bool isClicked = false;
  final formValidator = MultiValidator([
    RequiredValidator(errorText: 'harus diisi'),
    MinLengthValidator(8, errorText: 'Password minimal 8 karakter'),
  ]);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: Screen.blockX * 80,
        height: Screen.blockY * 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isClicked == true
                ? Flexible(
                    flex: 1,
                    child: Text(
                      widget.hint,
                      style: GoogleFonts.poppins(
                          fontSize: Screen.blockX * 4, color: Colors.grey),
                    ))
                : Container(),
            Flexible(
              flex: 2,
              child: TextFormField(
                obscureText: widget.hint == "Kata sandi" ? true : false,
                controller: widget.controller,
                style: GoogleFonts.poppins(fontSize: Screen.blockX * 5),
                validator: formValidator,
                onTap: () {
                  setState(() {
                    isClicked = true;
                  });
                },
                onFieldSubmitted: (_) {
                  setState(() {
                    isClicked = false;
                  });
                },
                decoration: InputDecoration(
                    hintText: isClicked == true ? '' : widget.hint,
                    hoverColor: Colors.white,
                    hintStyle: GoogleFonts.poppins(color: Colors.grey),
                    fillColor: Colors.white,
                    focusColor: Colors.white),
              ),
            ),
          ],
        ));
  }
}
