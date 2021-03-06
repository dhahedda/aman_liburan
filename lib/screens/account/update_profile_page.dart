import 'package:aman_liburan/services/Screen.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController _fullname = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _age = TextEditingController();
  // TextEditingController _password = TextEditingController();
  // TextEditingController _domicile = TextEditingController();

  String gender = 'male';
  Widget _appBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title:
          Text('Ubah Profil', style: GoogleFonts.poppins(color: Colors.black)),
      backgroundColor: Colors.white,
      elevation: 0.0,
    );
  }

  Widget _titleUserProfile() {
    return SizedBox(
      width: SizeConfig.getWidth(context) / 100 * 80,
      child: Text('DATA DIRI',
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
              fontSize: SizeConfig.getWidth(context) / 100 * 3.5, color: Colors.black)),
    );
  }

  Widget _updatePhoto() {
    return InkWell(
      onTap: () => print('upload foto'),
      child: Column(
        children: [
          Container(
            child: Icon(
              Icons.camera_alt,
              size: SizeConfig.getWidth(context) / 100 * 25,
              color: Colors.grey,
            ),
          ),
          Text('Ubah foto',
              style: GoogleFonts.poppins(fontSize: SizeConfig.getWidth(context) / 100 * 4)),
        ],
      ),
    );
  }

  Widget _fieldFullName() {
    return TextField(
      hint: 'Nama Lengkap',
      controller: _fullname,
    );
  }

  Widget _selectGender() {
    return Container(
      width: SizeConfig.getWidth(context) / 100 * 80,
      child: Row(
        children: [
          Row(
            children: [
              Radio(
                value: 'male',
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    print(value);
                    gender = value;
                  });
                },
              ),
              Text(
                'Laki-laki',
                style: GoogleFonts.poppins(fontSize: SizeConfig.getWidth(context) / 100 * 5),
              )
            ],
          ),
          Row(
            children: [
              Radio(
                value: 'female',
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    print(value);
                    gender = value;
                  });
                },
              ),
              Text(
                'Perempuan',
                style: GoogleFonts.poppins(fontSize: SizeConfig.getWidth(context) / 100 * 5),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _fieldAge() {
    return TextField(
      hint: 'Usia Pengguna',
      controller: _age,
    );
  }

  Widget _fieldDomicile() {
    return TextField(
      hint: 'Domisili',
      controller: _age,
    );
  }

  Widget _fieldUserName() {
    return TextField(
      hint: 'Username',
      controller: _username,
    );
  }

  Widget _titlePassword() {
    return SizedBox(
      width: SizeConfig.getWidth(context) / 100 * 80,
      child: Text('\nPASSWORD',
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
              fontSize: SizeConfig.getWidth(context) / 100 * 3.5, color: Colors.black)),
    );
  }

  Widget _fieldPassword() {
    return TextField(
      hint: 'Password',
      controller: _username,
    );
  }

  Widget _fieldPasswordAgain() {
    return TextField(
      hint: 'Ketik ulang password',
      controller: _username,
    );
  }

  Widget _saveButton() {
    return CustomButton(
      color: CustomColor().primary,
      fontColor: Colors.white,
      width: SizeConfig.getWidth(context) / 100 * 80,
      hint: 'SIMPAN DATA',
      function: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _appBar(),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _titleUserProfile(),
                  _updatePhoto(),
                  _fieldFullName(),
                  _selectGender(),
                  _fieldAge(),
                  _fieldDomicile(),
                  _fieldUserName(),
                  _titlePassword(),
                  _fieldPassword(),
                  _fieldPasswordAgain(),
                  _saveButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  const TextField({Key key, this.hint, this.controller}) : super(key: key);
  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  final formValidator = MultiValidator([
    RequiredValidator(errorText: 'harus diisi'),
    MinLengthValidator(8, errorText: 'Password minimal 8 karakter'),
  ]);
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
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
                      widget.hint,
                      style: GoogleFonts.poppins(
                          fontSize: SizeConfig.getWidth(context) / 100 * 4, color: Colors.grey),
                    ))
                : Container(),
            Flexible(
              flex: 2,
              child: TextFormField(
                obscureText: widget.hint == "Kata sandi" ? true : false,
                controller: widget.controller,
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