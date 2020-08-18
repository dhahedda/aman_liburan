import 'package:flutter/material.dart';

class CustomRangeSliderValueIndicatorCircle extends RangeSliderValueIndicatorShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomRangeSliderValueIndicatorCircle({
    @required this.thumbRadius,
    this.min = 0,
    this.max = 10,
  });

  @override
  Size getPreferredSize(
    bool isEnabled,
    bool isDiscrete, {
    TextPainter labelPainter,
    double textScaleFactor,
  }) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    bool isOnTop,
    TextPainter labelPainter,
    double textScaleFactor,
    Size sizeWithOverflow,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    Thumb thumb,
  }) {
    // final thousandsFormatter = NumberFormat('#,###.##', 'ja_JA');
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
      style: new TextStyle(
        fontSize: thumbRadius * .8,
        fontWeight: FontWeight.w700,
        // color: sliderTheme.thumbColor,
        // color: colorOrangeGaijin,
        color: Colors.transparent,
      ),
      // text: getValue(value),
      text: '¥${getValue(value)}',
    );

    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter = Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2) - 50);

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    // NumberFormat('#,###.##', 'ja_JA') but not one line
    // not a clean code
    final stringRoundedValue = ((max * value).round()).toString();
    final splitSize = 3;
    final modResult = stringRoundedValue.length % splitSize;
    String leading = stringRoundedValue.substring(0, modResult);
    final trailing = stringRoundedValue.substring(modResult);
    RegExp exp = RegExp(r"\d{" + "$splitSize" + "}");
    Iterable<Match> matches = exp.allMatches(trailing);
    // var list = matches.map((m) => int.tryParse(m.group(0)));
    // final formattedString = list.join(',');
    var list = matches.map((m) => m.group(0).toString());
    final formattedString = list.toList().join(',');
    // return stringRoundedValue + ' ' + leading + ',' + formattedString;
    if (leading.isNotEmpty && leading != '0') leading += ',';
    return leading + formattedString;
    // return stringRoundedValue + ' ' + leading + ',' + trailing;
    // return ((max * value).round()).toString();
  }
}
