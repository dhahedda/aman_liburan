import 'package:aman_liburan/services/Screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/Screen.dart';
import '../services/Screen.dart';
import '../services/Screen.dart';
import '../services/Screen.dart';
import '../services/Screen.dart';
import 'login_page.dart';
import 'register_page.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor().primary,
      child: SafeArea(
        child: Scaffold(backgroundColor: Colors.white, body: _UserProfile()),
      ),
    );
  }
}

class _UserProfile extends StatelessWidget {
  bool login = true;
  Widget _decoration() {
    return Stack(
      children: [
        Container(
          width: Screen.x,
          child: SvgPicture.asset(
            'images/img_rec.svg',
            fit: BoxFit.fill,
          ),
        ),
        Container(
          width: Screen.x,
          child: SvgPicture.asset(
            'images/img_bg_profile.svg',
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  Widget _userNotLogin() {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: Icon(
                  Icons.person_pin,
                  color: Colors.white,
                  size: Screen.blockX * 25,
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      color: Colors.white,
                      fontColor: CustomColor().primary,
                      hint: 'LOGIN',
                      width: Screen.blockX * 30,
                      function: () => Get.to(LoginPage()),
                    ),
                    CustomButton(
                      color: CustomColor().primary,
                      fontColor: Colors.white,
                      hint: 'DAFTAR',
                      width: Screen.blockX * 30,
                      function: () => Get.to(RegisterPage()),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _userLogin() {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 4,
                child: Icon(
                  Icons.person_pin,
                  color: Colors.white,
                  size: Screen.blockX * 25,
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Abang Tukang Bakso (L)',
                        style: GoogleFonts.poppins(fontSize: Screen.blockX * 5),
                      ),
                      Text(
                        'Wisatawan',
                        style: GoogleFonts.poppins(fontSize: Screen.blockX * 4),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _userInfoEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EMAIL',
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: Screen.blockX * 3),
        ),
        Text('baksobelumnikah@gmail.com',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: Screen.blockX * 4))
      ],
    );
  }

  Widget _userInfoDetailFunc(String hint, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: Screen.blockX * 3),
        ),
        Text(value,
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: Screen.blockX * 4))
      ],
    );
  }

  Widget _userInfoDetail() {
    return Row(
      children: [
        Expanded(flex: 1, child: _userInfoDetailFunc('USERNAME', '@baksobm')),
        Expanded(flex: 1, child: _userInfoDetailFunc('DOMISILI', 'Bandung')),
        Expanded(flex: 1, child: _userInfoDetailFunc('USIA', '25 Tahun')),
      ],
    );
  }

  Widget _userInfoButton() {
    return CustomButton(
      color: CustomColor().primary,
      fontColor: Colors.white,
      width: Screen.blockX * 80,
      hint: 'UBAH PROFIL',
    );
  }

  Widget _userInfo() {
    return Container(
      margin: EdgeInsets.only(top: Screen.blockY * 1),
      padding: EdgeInsets.all(Screen.blockX * 3),
      width: Screen.blockX * 90,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: _userInfoEmail()),
          Expanded(flex: 1, child: _userInfoDetail()),
          Expanded(flex: 1, child: _userInfoButton()),
        ],
      ),
    );
  }

  Widget _lastVisit() {
    return Container(
      margin: EdgeInsets.all(Screen.blockY * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Text(
                'Kunjungan terakhir',
                style: GoogleFonts.poppins(fontSize: Screen.blockX * 4),
              )),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 3)
                  ]),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            image: DecorationImage(
                                image: AssetImage('images/grojogan-sewu.jpg'),
                                fit: BoxFit.fill)),
                      )),
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: EdgeInsets.only(left: Screen.blockX * 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '12 Januari 2020',
                            style: GoogleFonts.poppins(
                                fontSize: Screen.blockX * 3),
                          ),
                          Text(
                            'Grojogan Sewu',
                            style: GoogleFonts.poppins(
                                fontSize: Screen.blockX * 5),
                          ),
                          Text(
                            '5 orang',
                            style: GoogleFonts.poppins(
                                fontSize: Screen.blockX * 3),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomDecorationLogin() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: _lastVisit(),
        ),
        Expanded(
          flex: 2,
          child: FlatButton.icon(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.red,
              size: Screen.blockX * 10,
            ),
            label: Text(
              'Logout',
              style: GoogleFonts.poppins(
                  color: Colors.red, fontSize: Screen.blockX * 5),
            ),
            onPressed: null,
          ),
        )
      ],
    );
  }

  Widget _bottomDecorationNotLogin() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: Image.asset('images/img_man_walking.png'),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text('Tetap pakai masker dan jaga jarak, ya.',
                          style:
                              GoogleFonts.poppins(fontSize: Screen.blockX * 5)),
                    ),
                    CustomButton(
                      color: CustomColor().primary,
                      fontColor: Colors.white,
                      function: null,
                      width: Screen.blockX * 50,
                      hint: 'TENTANG KAMI',
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              _decoration(),
              login == true ? _userLogin() : _userNotLogin()
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: login == true ? _userInfo() : Container(),
        ),
        Expanded(
          flex: 1,
          child: login == true
              ? _bottomDecorationLogin()
              : _bottomDecorationNotLogin(),
        )
      ],
    );
  }
}
