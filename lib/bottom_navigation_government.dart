import 'package:flutter/material.dart';
import 'package:aman_liburan/page.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class BottomNavigationGovernment extends StatelessWidget {
  final BottomPage page;
  final ValueChanged<BottomPage> onSelectPage;

  const BottomNavigationGovernment({Key key, this.page, this.onSelectPage}) : super(key: key);

  Color _color(BottomPage page) => this.page == page ? Theme.Colors.turqoiseDark : Theme.Colors.turqoiseNormal;


  // static const Map<BottomPage, String> icons = {
  //   BottomPage.page_1: "assets/images/bottom_navigation/bx_bx-home-alt.png",
  //   BottomPage.page_2: "assets/images/bottom_navigation/ant-design_user-outlined.png",
  // };

  // static const Map<BottomPage, String> names = {
  //   BottomPage.page_1: 'Home',
  //   BottomPage.page_2: 'Profile',
  // };

  static const Map<BottomPage, String> icons = {
    BottomPage.page_1: "assets/images/bottom_navigation/stats.png",
    BottomPage.page_2: "assets/images/bottom_navigation/tree.png",
    BottomPage.page_3: "assets/images/bottom_navigation/track.png",
    BottomPage.page_4: "assets/images/bottom_navigation/users.png",
  };

  static const Map<BottomPage, String> names = {
    BottomPage.page_1: 'Beranda',
    BottomPage.page_2: 'Wisata',
    BottomPage.page_3: 'Track',
    BottomPage.page_4: 'Pengguna',
  };

  Widget _buildTile(BottomPage bottomPage) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelectPage(bottomPage),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              icons[bottomPage],
              width: 24.0,
              height: 24.0,
              color: (page == bottomPage) ? _color(bottomPage) : Theme.Colors.turqoiseNormal,
            ),
            Text(
              names[bottomPage],
              style: TextStyle(
                color: _color(bottomPage),
                letterSpacing: 1,
                fontSize: 10.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 2.0),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ClipPath(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Container(
            width: SizeConfig.getWidth(context),
            height: 50.0,
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(color: colorSecondary, offset: Offset(2.0, 2.0), blurRadius: 10.0, spreadRadius: 10.0),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildTile(BottomPage.page_1),
                _buildTile(BottomPage.page_2),
                _buildTile(BottomPage.page_3),
                _buildTile(BottomPage.page_4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
