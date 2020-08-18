import 'package:flutter/material.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';

class IllustrationLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.getWidth(context),
      height: SizeConfig.getHeight(context),
      color: colorSoftBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Container(
          //   margin: const EdgeInsets.all(32.0),
          //   width: 250.0,
          //   height: 250.0,
          //   child: Image.asset('assets/images/illustrations/LoadingIllustration.png'),
          // ),
          Text(
            'Loading...',
            style: TextStyle(
              fontSize: 32.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
    );
  }
}
