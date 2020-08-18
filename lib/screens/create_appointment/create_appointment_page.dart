import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aman_liburan/blocs/create_appointment/create_appointment_bloc.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/screens/create_appointment/error_create_appointment.dart';
import 'package:aman_liburan/screens/create_appointment/success_create_appointment.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';

class CreateAppointmentPage extends StatefulWidget {
  final GlobalResponse response;

  CreateAppointmentPage({Key key, this.response}) : super(key: key);

  @override
  _CreateAppointmentPageState createState() =>
      _CreateAppointmentPageState(response);
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  final GlobalResponse response;

  _CreateAppointmentPageState(this.response);

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

    BlocProvider.of<CreateAppointmentBloc>(context)
        .add(DateChangeEvent(selectedDateTime: selectedDateTime));
  }

  void onSubmitAppointmentPressed(
    BuildContext context,
    GlobalResponse response,
    DateTime selectedDateTime,
  ) {
    // Validation Meeting Time
    if (selectedDateTime == null) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => AlertDialog(
          title: Text('Meeting Time is required'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 12.0,
          content: Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              ButtonTheme(
                minWidth: 180,
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: colorBlueGaijin,
                  child: Text(
                    "ok",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      print("Submit form..");

      double latitude = response.data.item.location.latitude;
      double longitude = response.data.item.location.longitude;
      var timemilist = new DateTime.utc(
        selectedDateTime.year,
        selectedDateTime.month,
        selectedDateTime.day,
        selectedDateTime.hour,
        selectedDateTime.minute,
      ).toUtc();

      int meetingTime = timemilist.millisecondsSinceEpoch;
      String productId = response.data.item.id;
      String sellerId = response.data.seller.id;
      String status = "pending";
      bool isDelivery = false;

      CreateAppointmentParam param = CreateAppointmentParam(
        status: status,
        isDelivery: isDelivery,
        meetingTime: meetingTime,
        meetingLat: latitude,
        meetingLng: longitude,
        productId: productId,
        sellerId: sellerId,
      );

      BlocProvider.of<CreateAppointmentBloc>(context)
          .add(SubmitAppointmentEvent(createAppointmentParam: param));
    }
  }

  @override
  Widget build(BuildContext context) {
    ItemResponse detailItem = response.data.item;
    SellerResponse seller = response.data.seller;
    String productPrice = "¥ ${detailItem.price.toString()}";

    return BlocProvider<CreateAppointmentBloc>(
      create: (context) => CreateAppointmentBloc()
        ..add(
          InitialCreateappointmentEvent(
            selectedDateTime: null,
            response: response,
          ),
        ),
      child: BlocBuilder<CreateAppointmentBloc, CreateAppointmentState>(
        builder: (context, state) {
          if (state is CreateAppointmentInitial) {
            print("Rebuild CreateappointmentInitial");
            return Container(
              width: SizeConfig.getWidth(context),
              height: 400,
              color: colorBlueGaijin,
            );
          } else if (state is CreateAppointmentResponse) {
            String distanceRadius = state.distanceRadius;
            
            return Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(Icons.close, color: colorDarkBackground),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  "Make Appointment",
                  style: TextStyle(
                    color: colorDarkBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Description
                      Container(
                        width: SizeConfig.getWidth(context),
                        height: SizeConfig.getHeight(context) * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colorSoftBlue,
                              blurRadius: 20.0,
                              spreadRadius: 5.0,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                fit: StackFit.expand,
                                children: [
                                  Align(
                                    alignment: Alignment(0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      child: Image.network(
                                        detailItem.images[0].imgUrl,
                                        fit: BoxFit.cover,
                                        width: 100.0,
                                      ),
                                    ),
                                  ),
                                  // Align(
                                  //   alignment: Alignment(0.0, 0.0),
                                  //   child: Text("Available"),
                                  // )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    detailItem.name,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: colorDarkBackground,
                                      letterSpacing: 1,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                                  Text(
                                    seller.firstName + " " + seller.lastName,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: colorDarkBackground,
                                      letterSpacing: 1,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    productPrice,
                                    style: TextStyle(
                                      color: colorSecondary,
                                      letterSpacing: 1,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: IconTheme(
                                            data: IconThemeData(
                                                color: colorDarkBackground,
                                                opacity: 0.5),
                                            child: Icon(
                                              Icons.location_on,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: distanceRadius,
                                          style: TextStyle(
                                            color: colorDarkBackground,
                                            letterSpacing: 1,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Nunito",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

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
                          fontFamily: "Nunito",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  (state is CreateAppointmentResponse)
                                      ? (state.selectedDateTime == null
                                          ? 'Choose a date'
                                          : state.selectedDateTime.toString())
                                      : "Choose a date",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: colorDarkBackground,
                                    letterSpacing: 1,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Nunito",
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
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
                child: ButtonTheme(
                  minWidth: 60.0,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () {
                      print("Confirm appointment Button Pressed");

                      return onSubmitAppointmentPressed(
                        context,
                        response,
                        state.selectedDateTime,
                      );
                    },
                    padding: const EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    color: colorBlueGaijin,
                    child: Text(
                      'Confirm appointment request',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (state is SubmitAppointmentResponse) {
            if (state.response.status == "Success") {
              return SuccessCreateAppointmentPage(response: state.response);
            } else {
              return ErrorCreateAppointmentPage(response: state.response);
            }
          } else {
            return Container(
              width: SizeConfig.getWidth(context),
              height: 400,
              color: Colors.red,
            );
          }
        },
      ),
    );
  }
}
