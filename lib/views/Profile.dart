import 'package:aman_liburan/services/Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LoginPage.dart';
import 'RegisterPage.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor().primary,
      child: SafeArea(
        child: Scaffold(body: _UserProfile()),
      ),
    );
  }
}

class _UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Stack(
            children: [
              Container(
                width: Screen.x,
                child: SvgPicture.asset(
                  'images/green_half_circle.svg',
                  fit: BoxFit.fill,
                ),
              ),
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
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
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
                      flex: 3,
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
                            child: Text(
                                'Tetap pakai masker dan jaga jarak, ya.',
                                style: GoogleFonts.poppins(
                                    fontSize: Screen.blockX * 5)),
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
          ),
        )
      ],
    );
  }
}
