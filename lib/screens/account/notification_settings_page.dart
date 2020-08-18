import 'package:flutter/material.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorGreyGaijin),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(),
    );
  }
}
