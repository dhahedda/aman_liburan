import 'package:aman_liburan/services/screen.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/views/login_page.dart';
import 'package:aman_liburan/views/register_page.dart';
import 'package:aman_liburan/views/update_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aman_liburan/components/data_session.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLogin = false;
  String _email = '';

  Future<void> _initLoginStatus() async {
    print('Getting login status...');
    _isLogin = await DataSession().getStatusLogin();
    _email = await DataSession().getEmail();
    setState(() {});
    print('Done');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initLoginStatus();
  }

  Widget _decoration() {
    return Stack(
      children: [
        Container(
          width: SizeConfig.getWidth(context),
          child: SvgPicture.asset(
            'images/img_rec.svg',
            fit: BoxFit.fill,
          ),
        ),
        Container(
          width: SizeConfig.getWidth(context),
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
                  size: SizeConfig.getWidth(context) / 100 * 25,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(top: SizeConfig.getHeight(context) / 100 * 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        color: Colors.white,
                        fontColor: CustomColor().primary,
                        hint: 'LOGIN',
                        width: SizeConfig.getWidth(context) / 100 * 30,
                        function: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        ),
                      ),
                      CustomButton(
                        color: CustomColor().primary,
                        fontColor: Colors.white,
                        hint: 'DAFTAR',
                        width: SizeConfig.getWidth(context) / 100 * 30,
                        function: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        ),
                      )
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

  Widget _userLogin() {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Icon(
                  Icons.person_pin,
                  color: Colors.white,
                  size: SizeConfig.getWidth(context) / 100 * 25,
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Abang Tukang Bakso (L)',
                        style: GoogleFonts.poppins(fontSize: SizeConfig.getWidth(context) / 100 * 5),
                      ),
                      Text(
                        'Wisatawan',
                        style: GoogleFonts.poppins(fontSize: SizeConfig.getWidth(context) / 100 * 4),
                      ),
                    ],
                  ),
                ),
              ),
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
          style: GoogleFonts.poppins(color: Colors.black, fontSize: SizeConfig.getWidth(context) / 100 * 3),
        ),
        Text(
          _email,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: SizeConfig.getWidth(context) / 100 * 4,
          ),
        )
      ],
    );
  }

  Widget _userInfoDetailFunc(String hint, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: GoogleFonts.poppins(color: Colors.black, fontSize: SizeConfig.getWidth(context) / 100 * 3),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(color: Colors.black, fontSize: SizeConfig.getWidth(context) / 100 * 4),
        )
      ],
    );
  }

  Widget _userInfoDetail() {
    return Row(
      children: [
        Expanded(child: _userInfoDetailFunc('USERNAME', '@baksobm')),
        Expanded(child: _userInfoDetailFunc('DOMISILI', 'Bandung')),
        Expanded(child: _userInfoDetailFunc('USIA', '25 Tahun')),
      ],
    );
  }

  Widget _userInfoButton() {
    return CustomButton(
      color: CustomColor().primary,
      fontColor: Colors.white,
      width: SizeConfig.getWidth(context) / 100 * 80,
      hint: 'UBAH PROFIL',
      function: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UpdateProfile()),
      ),
    );
  }

  Widget _userInfo() {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.getHeight(context) / 100 * 1),
      padding: EdgeInsets.all(SizeConfig.getWidth(context) / 100 * 3),
      width: SizeConfig.getWidth(context) / 100 * 90,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _userInfoEmail()),
          Expanded(child: _userInfoDetail()),
          Expanded(child: _userInfoButton()),
        ],
      ),
    );
  }

  Widget _lastVisit() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.getHeight(context) / 100 * 2, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kunjungan terakhir',
            style: GoogleFonts.poppins(fontSize: SizeConfig.getWidth(context) / 100 * 4),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        image: DecorationImage(image: AssetImage('images/grojogan-sewu.jpg'), fit: BoxFit.fill)),
                  )),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(left: SizeConfig.getWidth(context) / 100 * 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '12 Januari 2020',
                            style: GoogleFonts.poppins(fontSize: SizeConfig.getWidth(context) / 100 * 3),
                          ),
                          Text(
                            'Grojogan Sewu',
                            style: GoogleFonts.poppins(fontSize: SizeConfig.getWidth(context) / 100 * 5),
                          ),
                          Text(
                            '5 orang',
                            style: GoogleFonts.poppins(fontSize: SizeConfig.getWidth(context) / 100 * 3),
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
              size: SizeConfig.getWidth(context) / 100 * 10,
            ),
            label: Text(
              'Logout',
              style: GoogleFonts.poppins(color: Colors.red, fontSize: SizeConfig.getWidth(context) / 100 * 5),
            ),
            onPressed: null,
          ),
        )
      ],
    );
  }

  Widget _bottomDecorationNotLogin() {
    return Row(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Text('Tetap pakai masker dan jaga jarak, ya.', style: GoogleFonts.poppins(fontSize: SizeConfig.getWidth(context) / 100 * 5)),
              ),
              CustomButton(
                color: CustomColor().primary,
                fontColor: Colors.white,
                function: null,
                width: SizeConfig.getWidth(context) / 100 * 50,
                hint: 'TENTANG KAMI',
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              _decoration(),
              _isLogin ? _userLogin() : _userNotLogin(),
            ],
          ),
        ),
        Expanded(
          child: _isLogin ? _userInfo() : Container(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: _isLogin ? _bottomDecorationLogin() : _bottomDecorationNotLogin(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
  return Container(
      color: CustomColor().primary,
      child: SafeArea(
        child: Scaffold(backgroundColor: Colors.white, body: _buildBody()),
      ),
    );
  }
}
