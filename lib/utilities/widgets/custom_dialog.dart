import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:aman_liburan/utilities/widgets/custom_dialog_widget.dart';

class CustomDialog {
  // Fungsi Loading Dialog
  static Future<void> showLoadingDialog({
    @required BuildContext context,
    bool dismissible: false,
    bool popScope: false,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => popScope,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
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
                  SpinKitChasingDots(
                    color: Colors.blueAccent,
                    size: 50.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please Wait..",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showSuccessDialog({
    @required BuildContext context,
    @required String title,
    @required String message,
  }) {
    Image image = Image.asset('assets/images/success_appointment.png');
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => CustomDialogWidget(
        image: image,
        title: title,
        description: message,
        buttonText: "Ok",
      ),
    );
  }

  static Future<void> showInfoDialog({
    @required BuildContext context,
    @required String title,
    @required String message,
  }) {
    Image image = Image.asset('assets/images/publish_item.png');
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => CustomDialogWidget(
        image: image,
        title: title,
        description: message,
        buttonText: "Ok",
      ),
    );
  }

  static Future<void> showErrorDialog({
    @required BuildContext context,
    @required String title,
    @required String message,
  }) {
    Image image = Image.asset('assets/images/cancel_appointment.png');
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => CustomDialogWidget(
        image: image,
        title: title,
        description: message,
        buttonText: "Ok",
      ),
    );
  }

  static void hidePopupDialog({@required BuildContext context}) {
    Navigator.pop(context);
  }
}
