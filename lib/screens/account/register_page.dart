import 'package:aman_liburan/services/Screen.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
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

  Widget _decoration() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: SizeConfig.getHeight(context) / 100 * 10),
          width: SizeConfig.getWidth(context),
          child: SvgPicture.asset(
            'images/waves_blue.svg',
            fit: BoxFit.fill,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: SizeConfig.getHeight(context) / 100 * 10),
          width: SizeConfig.getWidth(context),
          child: SvgPicture.asset(
            'images/waves_green.svg',
            fit: BoxFit.fill,
          ),
        ),
        Container(
          width: SizeConfig.getWidth(context) / 100 * 25,
          child: Image.asset('images/ic.png'),
        ),
      ],
    );
  }

  Widget _textField(String hint, TextEditingController controller) {
    final formValidator = MultiValidator([
      RequiredValidator(errorText: 'harus diisi'),
      MinLengthValidator(8, errorText: 'Password minimal 8 karakter'),
    ]);
    bool isClicked = false;
    return Container(
        width: SizeConfig.getWidth(context) / 100 * 80,
        height: SizeConfig.getHeight(context) / 100 * 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isClicked == true
                ? Flexible(
                    flex: 1,
                    child: Text(
                      hint,
                      style: GoogleFonts.poppins(
                          fontSize: SizeConfig.getWidth(context) / 100 * 4, color: Colors.grey),
                    ))
                : Container(),
            Flexible(
              flex: 2,
              child: TextFormField(
                obscureText: hint == "Kata sandi" ? true : false,
                controller: controller,
                style: GoogleFonts.poppins(fontSize: SizeConfig.getWidth(context) / 100 * 5),
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
                    hintText: isClicked == true ? '' : hint,
                    hoverColor: Colors.white,
                    hintStyle: GoogleFonts.poppins(color: Colors.grey),
                    fillColor: Colors.white,
                    focusColor: Colors.white),
              ),
            ),
          ],
        ));
  }

  Widget _formRegister() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: SizeConfig.getHeight(context) / 100 * 20),
          height: Screen.y,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                            fontSize: SizeConfig.getWidth(context) / 100 * 6),
                      ),
                      _textField('Nama Lengkap', _fullname),
                      _textField('Username', _user),
                      _textField('Password', _password),
                      _textField('Domisili', _domicile),
                      CustomButton(
                        color: CustomColor().primary,
                        fontColor: Colors.white,
                        function: () => print('register'),
                        hint: 'REGISTER',
                        width: SizeConfig.getWidth(context) / 100 * 80,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '\nSudah punya akun? ',
                          style: GoogleFonts.poppins(
                              color: Colors.grey, fontSize: SizeConfig.getWidth(context) / 100 * 5),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Login',
                              style: GoogleFonts.poppins(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                            )
                          ],
                        ),
                      )
                    ],
                  ))),
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
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: KeyboardAvoider(
            autoScroll: true,
            child: Center(
              child: Stack(
                children: <Widget>[_decoration(), _formRegister()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
