import 'package:flutter/material.dart';

class HorizontalLine extends StatelessWidget {
  final double padding;
  final double width;
  final Color color;

  const HorizontalLine({ @required this.width, @required this.color, @required this.padding});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        width: width,
        height: 1.0,
        color: color,
      ),
    );
  }
}