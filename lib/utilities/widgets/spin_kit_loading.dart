import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';

// @Deprecated('Use IllustrationLoading instead.')
class SpinKitLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitThreeBounce(
          color: colorBlueGaijin,
          size: 20.0,
        ),
      ],
    );
  }
}