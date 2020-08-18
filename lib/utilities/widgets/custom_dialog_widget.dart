import 'package:flutter/material.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/horizontal_line.dart';

class CustomDialogWidget extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  final double padding;
  final double avatarRadius;

  CustomDialogWidget({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
    this.padding = 16.0,
    this.avatarRadius = 66.0,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: avatarRadius + padding,
            bottom: padding,
            left: padding,
            right: padding,
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              HorizontalLine(
                padding: 10,
                width: 200,
                color: colorSoftDark,
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: avatarRadius,
            child: image,
          ),
        ),
      ],
    );
  }
}
