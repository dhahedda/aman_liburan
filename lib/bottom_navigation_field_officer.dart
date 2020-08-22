import 'package:flutter/material.dart';
import 'package:aman_liburan/page.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class BottomNavigationFiledOfficer extends StatefulWidget {
  final BottomPage page;
  final ValueChanged<BottomPage> onSelectPage;

  const BottomNavigationFiledOfficer({Key key, this.page, this.onSelectPage}) : super(key: key);
  // static const Map<BottomPage, String> icons = {
  //   BottomPage.page_1: "assets/images/bottom_navigation/bx_bx-home-alt.png",
  //   BottomPage.page_2: "assets/images/bottom_navigation/ant-design_user-outlined.png",
  // };

  // static const Map<BottomPage, String> names = {
  //   BottomPage.page_1: 'Home',
  //   BottomPage.page_2: 'Profile',
  // };

  // static const Map<BottomPage, String> icons = {
  //   BottomPage.page_1: "assets/images/bottom_navigation/stats.png",
  //   BottomPage.page_2: "assets/images/bottom_navigation/tree.png",
  //   BottomPage.page_3: "assets/images/bottom_navigation/track.png",
  //   BottomPage.page_4: "assets/images/bottom_navigation/users.png",
  // };

  // static const Map<BottomPage, String> names = {
  //   BottomPage.page_1: 'Beranda',
  //   BottomPage.page_2: 'Wisata',
  //   BottomPage.page_3: 'Track',
  //   BottomPage.page_4: 'Pengguna',
  // };

  static const Map<BottomPage, String> icons = {
    BottomPage.page_1: "assets/images/bottom_navigation/feather_log-in.png",
    BottomPage.page_2: "assets/images/bottom_navigation/feather_log-out.png",
    BottomPage.page_3: "assets/images/bottom_navigation/feather_log-out.png",
  };

  static const Map<BottomPage, String> names = {
    BottomPage.page_1: 'Check In',
    BottomPage.page_2: 'Check Out',
    BottomPage.page_3: 'Check Out',
  };

  @override
  _BottomNavigationFiledOfficerState createState() => _BottomNavigationFiledOfficerState();
}

class _BottomNavigationFiledOfficerState extends State<BottomNavigationFiledOfficer> {
  bool _atHome = true;

  Color _color(BottomPage page) => this.widget.page == page ? Theme.Colors.turqoiseDark : Theme.Colors.turqoiseNormal;

  Widget _buildTile(BottomPage bottomPage) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onSelectPage(bottomPage);
          setState(() {
            _atHome = false;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              BottomNavigationFiledOfficer.icons[bottomPage],
              width: 24.0,
              height: 24.0,
              color: (widget.page == bottomPage) ? _color(bottomPage) : Theme.Colors.turqoiseNormal,
            ),
            Text(
              BottomNavigationFiledOfficer.names[bottomPage],
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
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: BottomShapeClipper(),
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
                    BoxShadow(
                      color: colorSecondary,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 10.0,
                      spreadRadius: 10.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildTile(BottomPage.page_1),
                    _buildTile(BottomPage.page_3),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: SizeConfig.getWidth(context) / 2.95,
          child: Container(
            width: 64.0,
            height: 64.0,
            margin: EdgeInsets.only(bottom: 24.0, left: 28.0),
            child: FloatingActionButton(
              onPressed: () {
                widget.onSelectPage(BottomPage.page_2);
                setState(() {
                  _atHome = true;
                });
              },
              elevation: 15.0,
              backgroundColor: _atHome ? Theme.Colors.turqoiseNormal : Colors.white,
              child: SizedBox(
                width: 32.0,
                height: 32.0,
                child: Image.asset(
                  "assets/images/bottom_navigation/feather_home.png",
                  width: 32.0,
                  height: 32.0,
                  color: _atHome ? Colors.white : Theme.Colors.turqoiseNormal,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BottomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..relativeLineTo(size.width / 2.5, 0)
      ..relativeQuadraticBezierTo(6, 30, 34, 32) // 24
      ..relativeQuadraticBezierTo(32, 2, 38, -32)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..close();
    // ..lineTo(24, 0)
    // ..quadraticBezierTo(30, 30, 58, 32)
    // ..quadraticBezierTo(90, 32, 96, 0)
    // ..lineTo(size.width, 0)
    // ..lineTo(size.width, size.height)
    // ..lineTo(0.0, size.height)
    // ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
