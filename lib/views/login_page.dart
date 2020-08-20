import 'package:aman_liburan/services/Screen.dart';
import 'package:aman_liburan/services/UserServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: unused_import
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'register_page.dart';

TextEditingController _password = TextEditingController();
TextEditingController _user = TextEditingController();

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  static const route = '/login';
  final _formKey = GlobalKey<FormState>();
  void dispose() {
    _password.clear();
    _user.clear();
    super.dispose();
  }

  Widget _decoration() {
    return Stack(
      children: [
        Positioned(
          top: Screen.blockY * 0,
          left: Screen.blockX * 0,
          width: Screen.blockX * 30,
          child: Image.asset('images/ic.png'),
        ),
        Positioned(
          top: Screen.blockY * 25,
          left: 0,
          width: Screen.x,
          child: SvgPicture.asset(
            'images/waves_blue.svg',
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: Screen.blockY * 25,
          left: 0,
          width: Screen.x,
          child: SvgPicture.asset(
            'images/waves_green.svg',
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  Widget _textField(String hint) {
    final formValidator = MultiValidator([
      RequiredValidator(errorText: 'harus diisi'),
      MinLengthValidator(8, errorText: 'Password minimal 8 karakter'),
    ]);
    return TextFormField(
      obscureText: hint == "Kata sandi" ? true : false,
      controller: hint == "Kata sandi" ? _password : _user,
      style: TextStyle(color: Colors.black87),
      validator: formValidator,
      decoration: InputDecoration(
          hintText: hint,
          hoverColor: Colors.white,
          hintStyle: GoogleFonts.poppins(color: Colors.grey),
          fillColor: Colors.white,
          focusColor: Colors.white),
    );
  }

  Widget _form(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: Screen.blockY * 35,
          width: Screen.blockX * 100,
          height: Screen.blockY * 65,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: Screen.blockX * 10,
                    width: Screen.blockX * 80,
                    child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '\nLogin',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Screen.blockX * 6),
                            ),
                            _textField("Email"),
                            _textField("Kata sandi"),
                            Text('\n\n'),
                            CustomButton(
                              color: CustomColor().primary,
                              fontColor: Colors.white,
                              function: () => UserServices()
                                  .signIn(_user.text, _password.text),
                              hint: 'LOGIN',
                              width: Screen.blockX * 80,
                            ),
                            CustomButton(
                              color: Colors.white,
                              fontColor: CustomColor().primary,
                              function: () => Get.to(RegisterPage()),
                              hint: 'REGISTER',
                              width: Screen.blockX * 80,
                            ),
                            FlatButton(
                              child: Text(
                                'Lupa password?',
                                style: GoogleFonts.poppins(
                                    fontSize: Screen.blockX * 5),
                              ),
                              onPressed: null,
                            )
                          ],
                        ))),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return Container(
      color: CustomColor().primary,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Stack(
              children: <Widget>[_decoration(), _form(context)],
            ),
          ),
        ),
      ),
    );
  }
}
