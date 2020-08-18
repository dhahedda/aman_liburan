import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final Color color;
  final Color backgrounColor;
  final double padding;
  final double iconSize;

  const CircleButton({Key key, @required this.onTap, @required this.iconData, @required this.color, @required this.backgrounColor, @required this.padding, @required this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgrounColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            iconData,
            size: iconSize,
            color: color,
          ),
        ),
      ),
    );
  }
}