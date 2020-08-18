import 'package:flutter/material.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';

class ErrorCreateAppointmentPage extends StatelessWidget {
  final GlobalResponse response;
  const ErrorCreateAppointmentPage({Key key, this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 75.0),
                child: Image(
                  width: 200,
                  height: 250,
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/cancel_appointment.png'),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  "Appointment request failed..",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                child: Text(
                  "Some Error Happen => ${response.message}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorGreyGaijin,
                    letterSpacing: 1,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  "View Detail",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorSecondary,
                    letterSpacing: 1,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
        child: ButtonTheme(
          minWidth: 60.0,
          child: RaisedButton(
            elevation: 5.0,
            onPressed: () {
              print("Button Back to Home Pressed");
              Navigator.of(context).pop();
            },
            padding: const EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: colorBlueGaijin,
            child: Text(
              'Back to Previous Page',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ),
    );
  }
}