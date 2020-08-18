import 'package:flutter/material.dart';

final Color colorBlueGaijin = Color(0xFF0674ec);
final Color colorBlueGaijin80 = Color(0x800674ec);
final Color colorGreyGaijin = Color(0xFF747b86);
final Color colorOrangeGaijin = Color(0xFFEF7132);
final Color colorDarkBackground = Color(0xFF29343B);
final Color colorPrimary = Color(0xFF1B479E);
final Color colorSecondary = Color(0xFFEF7132);
final Color colorSecondaryBold = Color(0xFFEF5532);
final Color colorTertiary = Color(0xFFF2B530);
final Color colorSoftYellow = Color(0xFFFFF9D9);
final Color colorSoftDark = Color(0xFFE0E5EE);
final Color colorSoftBlue = Color(0xFFF2F7FF);
final Color colorSoftBlueBold = Color(0xFF8DA2CB);
final Color colorTosca = Color(0xFF00BFA5);
final Color colorWhite = Color(0xFFFFFFFF);
final Color colorPink = Color(0xFFFF3E6C);

final Color colorApparels = Color.fromRGBO(255, 61, 0, 0.25);
final Color colorBooks = Color.fromRGBO(255, 143, 0, 0.25);
final Color colorElectronics = Color.fromRGBO(101, 31, 255, 0.25);
final Color colorFootwear = Color.fromRGBO(255, 143, 0, 0.25);
final Color colorFurnitures = Color.fromRGBO(0, 230, 118, 0.25);
final Color colorKitchen = Color.fromRGBO(0, 188, 212, 0.25);
final Color colorSports = Color.fromRGBO(245, 0, 87, 0.25);
final Color colorVehicles = Color.fromRGBO(93, 64, 55, 0.25);
final Color colorWhiteAppliances = Color.fromRGBO(224, 64, 251, 0.25);
final Color colorMisc = Color.fromRGBO(63, 81, 181, 0.25);

final TextStyle customHintTextStyle = TextStyle(
  color: colorGreyGaijin,
  fontFamily: 'OpenSans',
  fontSize: 12.0,
);

final TextStyle customLabelStyle = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
  fontSize: 12.0,
);

final BoxDecoration customBoxDecorationStyle = BoxDecoration(
  color: Color(0xFFf4f5f8),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final BoxDecoration bordereBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 1.0,
      offset: Offset(0, 1),
    ),
  ],
  border: Border.all(
    width: 1,
    color: Colors.black12,
  ),
);
