import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color signinGradientStart = const Color(0xFFfbab66);
  static const Color signinGradientEnd = const Color(0xFFf7418c);

  static const Color turqoiseDark = const Color(0xFF5599AE);
  static const Color turqoiseNormal = const Color(0xFF66C6BA);
  static const Color turqoiseLight = const Color(0xFFA3E5D9);
  static const Color turqoiseLighter = const Color(0xFFD5F4E5);
  static const Color grey3 = const Color(0xFF828282);

  static const primaryGradient = const LinearGradient(
    colors: const [signinGradientStart, signinGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}