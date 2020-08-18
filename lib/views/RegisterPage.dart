import 'package:aman_liburan/services/Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: unused_import
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'RegisterPage.dart';

TextEditingController _password = TextEditingController();
TextEditingController _user = TextEditingController();

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  static const route = '/login';
  final _formKey = GlobalKey<FormState>();
  void dispose() {
    _password.clear();
    _user.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return SafeArea(
      child: Container(
          color: Colors.blue,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: Screen.blockY * 0,
                    left: Screen.blockX * 0,
                    width: Screen.blockX * 30,
                    child: Image.asset('images/ic.png'),
                  ),
                  Positioned(
                    top: Screen.blockY * 12,
                    left: 0,
                    width: Screen.x,
                    child: SvgPicture.asset(
                      'images/waves_blue.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: Screen.blockY * 12,
                    left: 0,
                    width: Screen.x,
                    child: SvgPicture.asset(
                      'images/waves_green.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: Screen.blockY * 20,
                    width: Screen.blockX * 100,
                    height: Screen.blockY * 80,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '\nDaftar\n',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: Screen.blockX * 6),
                                      ),
                                      _Form(hint: "Nama Lengkap"),
                                      _Form(hint: "Username"),
                                      _Form(hint: "Password"),
                                      _Form(hint: "Domisili"),
                                      Text('\n'),
                                      CustomButton(
                                        color: CustomColor().primary,
                                        fontColor: Colors.white,
                                        function: () => print('login'),
                                        hint: 'REGISTER',
                                        width: Screen.blockX * 80,
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

// ignore: todo
/*TODO: textfield untuk email dan password
  // ignore: todo
  TODO: menggunakan validator untuk verifikasi format email dan password
 */
class _Form extends StatefulWidget {
  final String hint;
  const _Form({Key key, this.hint}) : super(key: key);
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final formValidator = MultiValidator([
    RequiredValidator(errorText: 'harus diisi'),
    MinLengthValidator(8, errorText: 'Password minimal 8 karakter'),
  ]);
  @override
  Widget build(BuildContext context) {
    if (widget.hint == "Kata sandi") {
      return TextFormField(
        obscureText: true,
        controller: _password,
        style: TextStyle(color: Colors.white),
        validator: formValidator,
        decoration: InputDecoration(
            hintText: widget.hint,
            hoverColor: Colors.white,
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
            fillColor: Colors.white,
            focusColor: Colors.white),
      );
    } else {
      return TextFormField(
        controller: _user,
        validator: formValidator,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: GoogleFonts.poppins(color: Colors.grey)),
      );
    }
  }
}
