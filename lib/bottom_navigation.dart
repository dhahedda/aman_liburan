import 'package:flutter/material.dart';
import 'package:aman_liburan/page.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class BottomNavigation extends StatelessWidget {
  final BottomPage page;
  final ValueChanged<BottomPage> onSelectPage;

  const BottomNavigation({Key key, this.page, this.onSelectPage})
      : super(key: key);

  Color _color(BottomPage page) =>
      this.page == page ? Theme.Colors.turqoiseDark : Theme.Colors.turqoiseNormal;

  static const Map<BottomPage, String> icons = {
    BottomPage.page_1: "assets/images/bottom_navigation/home.png",
    BottomPage.page_2: "assets/images/bottom_navigation/my_profile.png",
  };

  static const Map<BottomPage, String> names = {
    BottomPage.page_1: 'Home',
    BottomPage.page_2: 'Profile',
  };

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
            padding: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                    color: colorSecondary,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 10.0,
                    spreadRadius: 10.0),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => onSelectPage(BottomPage.page_1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          icons[BottomPage.page_1],
                          width: 24,
                          height: 24,
                          color: (page == BottomPage.page_1)
                              ? _color(BottomPage.page_1)
                              : Theme.Colors.turqoiseNormal,
                        ),
                        Text(
                          names[BottomPage.page_1],
                          style: TextStyle(
                            color: _color(BottomPage.page_1),
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
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => onSelectPage(BottomPage.page_2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          icons[BottomPage.page_2],
                          width: 24,
                          height: 24,
                          color: (page == BottomPage.page_2)
                              ? _color(BottomPage.page_2)
                              : Theme.Colors.turqoiseNormal,
                        ),
                        Text(
                          names[BottomPage.page_2],
                          style: TextStyle(
                            color: _color(BottomPage.page_2),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}