import 'package:flutter/material.dart';
import 'package:aman_liburan/models/response/appointment/appointment_response.dart';
import 'package:aman_liburan/models/subscription_model.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';

class RescheduleAppointmentDialogPage extends StatefulWidget {
  final AppointmentResponse appointmentParam;
  final VoidCallback onSubmit;
  final Function(DateTime) onDateChange;

  RescheduleAppointmentDialogPage(
      {Key key, this.appointmentParam, this.onSubmit, this.onDateChange})
      : super(key: key);

  @override
  _RescheduleAppointmentDialogPageState createState() =>
      _RescheduleAppointmentDialogPageState(
          appointmentParam, onSubmit, onDateChange);
}

class _RescheduleAppointmentDialogPageState
    extends State<RescheduleAppointmentDialogPage> {
  final AppointmentResponse appointmentParam;
  final VoidCallback onSubmit;
  final Function(DateTime) onDateChange;
  DateTime rescheduleDate;

  _RescheduleAppointmentDialogPageState(
    this.appointmentParam,
    this.onSubmit,
    this.onDateChange,
  );

  @override
  void initState() {
    super.initState();
    rescheduleDate = appointmentParam.meetingTime;
  }

  Future _selectDateTime(BuildContext context) async {
    final now = DateTime.now();

    DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100),
    );
    if (selectedDate == null) return;

    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
    if (selectedTime == null) return;

    DateTime selectedDateTime = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedTime.hour, selectedTime.minute);
    setState(() {
      rescheduleDate = selectedDateTime;
      onDateChange(rescheduleDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        color: Color(0xFF737373),
        height: SizeConfig.getHeight(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 8,
                top: 8,
                child: IconButton(
                  icon: Icon(Icons.close, color: colorDarkBackground),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        width: 170,
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/reschedule.png'),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 250,
                        child: Text(
                          "Reschedule",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 220,
                        child: Text(
                          "Reschedule Appointment?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colorDarkBackground,
                            letterSpacing: 1,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorGreyGaijin,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0),
                            bottomLeft: const Radius.circular(10.0),
                            bottomRight: const Radius.circular(10.0),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 16.0),
                            // Date Time
                            Text(
                              "When do you want to meet?",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: colorDarkBackground,
                                letterSpacing: 1,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Poppins",
                              ),
                            ),
                            SizedBox(height: 8.0),
                            InkWell(
                              onTap: () {
                                _selectDateTime(context);
                              },
                              child: Container(
                                width: SizeConfig.getWidth(context),
                                alignment: Alignment.center,
                                decoration: bordereBoxDecorationStyle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        rescheduleDate == null
                                            ? 'Choose a date'
                                            : rescheduleDate.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: colorDarkBackground,
                                          letterSpacing: 1,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                      IconTheme(
                                        data: IconThemeData(
                                          color: colorDarkBackground,
                                          opacity: 0.5,
                                        ),
                                        child: Icon(
                                          Icons.date_range,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                elevation: 3.0,
                                onPressed: onSubmit,
                                padding: EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                color: colorPrimary,
                                child: Text(
                                  "Reschedule Appointment",
                                  style: TextStyle(
                                    height: 1.4,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionItem extends StatelessWidget {
  final SubscriptionModel _item;
  SubscriptionItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: _item.isSelected ? colorSecondary : Colors.transparent,
        border: Border.all(
          width: 2,
          color: _item.isSelected ? colorSecondary : Colors.transparent,
        ),
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                height: 30.0,
                width: 30.0,
                child: _item.isSelected
                    ? Icon(
                        Icons.check,
                        color: colorSecondary,
                        size: 20,
                      )
                    : Container(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 2,
                    color: colorSecondary,
                  ),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(360.0)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(left: 8.0),
              child: Text(
                _item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _item.isSelected ? Colors.white : colorDarkBackground,
                  letterSpacing: 1,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    _item.price,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color:
                          _item.isSelected ? Colors.white : colorDarkBackground,
                      letterSpacing: 1,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    "per month",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color:
                          _item.isSelected ? Colors.white : colorDarkBackground,
                      letterSpacing: 1,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: (_item.discount == "")
                ? Container()
                : Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: _item.isSelected
                          ? Text(
                              _item.discount,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _item.isSelected
                                    ? Colors.white
                                    : colorDarkBackground,
                                letterSpacing: 1,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                              ),
                            )
                          : Text(
                              _item.discount,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colorDarkBackground,
                                letterSpacing: 1,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                              ),
                            ),
                      decoration: BoxDecoration(
                        color: _item.isSelected
                            ? colorPrimary
                            : colorSoftBlueBold.withOpacity(0.6),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(10.0)),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
