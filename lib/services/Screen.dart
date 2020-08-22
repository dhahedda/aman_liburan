import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen {
  MediaQueryData _mediaQueryData;
  static double x;
  static double y;
  static double blockX;
  static double blockY;
  void init(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _mediaQueryData = MediaQuery.of(context);
    x = _mediaQueryData.size.width;
    y = _mediaQueryData.size.height;
    blockX = x / 100;
    blockY = y / 100;
  }
}

class CustomColor {
  final text = Color(0xFFFFFFFF);
  final primary = Color(0xFF66C6BA);
  final primary80 = Color(0xF0172F37);
  final primaryDark = Color(0xFF08191F);
}

class CustomText {
  final buttontext = TextStyle(color: Colors.white, fontSize: Screen.blockX * 4);
}

class Button extends StatelessWidget {
  final String action;
  final Function function;
  final double width;
  const Button({Key key, this.action, this.function, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(color: CustomColor().primary.withOpacity(0.4)),
      child: FlatButton(
        child: Text(
          action,
          style: CustomText().buttontext,
        ),
        onPressed: function,
      ),
    );
  }
}

class CustomCard extends StatefulWidget {
  final String title, subtitle;
  final Icon icon;
  final Function function;
  final Function longpress;
  final bool state;
  const CustomCard({Key key, this.title, this.icon, this.function, this.longpress, this.subtitle, this.state}) : super(key: key);
  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.state == true ? Colors.blue.withOpacity(0.5) : CustomColor().primaryDark,
      ),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
        leading: widget.icon,
        title: Text(widget.title, style: TextStyle(fontSize: Screen.blockX * 6, color: Colors.white)),
        subtitle: Text(
          widget.subtitle,
          style: TextStyle(fontSize: Screen.blockX * 4, color: Colors.white),
        ),
        onTap: widget.function,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color color;
  final String hint;
  final Function function;
  final Color fontColor;
  final double width;
  const CustomButton({Key key, this.color, this.hint, this.function, this.fontColor, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5), boxShadow: [
        BoxShadow(
          color: fontColor,
          spreadRadius: 1,
        )
      ]),
      child: FlatButton(
        child: Text(
          hint,
          style: GoogleFonts.poppins(
            color: fontColor,
            // fontSize: Screen.blockX * 5,
          ),
        ),
        onPressed: function,
      ),
    );
  }
}
