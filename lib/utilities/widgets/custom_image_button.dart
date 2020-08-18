import 'package:flutter/material.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';

class CustomImageButton extends StatelessWidget {
  final bool active;
  final Color backgroundColor;
  final AssetImage assetImage;
  final String text;
  final VoidCallback onTap;

  const CustomImageButton({
    Key key,
    @required this.active,
    @required this.backgroundColor,
    @required this.assetImage,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       this.onTap();
      },
      child: Container(
        width: 100,
        height: 75,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            active ? BoxShadow(
              color: Colors.blue[900],
              blurRadius: 4.0,
              spreadRadius:2.0
            ) : BoxShadow(
              color: Colors.black26,
              blurRadius: 1.0,
              offset: const Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: assetImage,
              height: 42,
              width: 38,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: 4.0),
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: colorDarkBackground,
                letterSpacing: 1,
                fontSize: 10.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            )
          ],
        ),
      ),
    );
  }
}
