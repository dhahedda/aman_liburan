import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:aman_liburan/blocs/appointment_seller/appointment_seller_bloc.dart';
import 'package:aman_liburan/blocs/chat/chat_bloc.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/screens/account/reschedule_appointment_dialog_page.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/custom_dialog.dart';
import 'package:aman_liburan/utilities/widgets/illustration_loading.dart';
import 'package:timeago/timeago.dart' as timeago;

class AppointmentSellerPage extends StatefulWidget {
  @override
  _AppointmentSellerPageState createState() => _AppointmentSellerPageState();
}

class _AppointmentSellerPageState extends State<AppointmentSellerPage> {
  Completer<void> _refreshCompleter;
  DateTime rescheduleDate;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  Future<void> rescheduleAppintment(
    BuildContext context,
    AppointmentResponse appointment,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => RescheduleAppointmentDialogPage(
          appointmentParam: appointment,
          onSubmit: () {
            // print("rescheduleDate=>"+rescheduleDate.toString());
            Navigator.pop(context);
            var timemilist = new DateTime.utc(
              rescheduleDate.year,
              rescheduleDate.month,
              rescheduleDate.day,
              rescheduleDate.hour,
              rescheduleDate.minute,
            ).toUtc();

            CustomDialog.showLoadingDialog(context: context);
            BlocProvider.of<AppointmentSellerBloc>(context).add(
              RescheduleAppointmentEvent(
                rescheduleAppointmentParam: RescheduleAppointmentParam(
                  id: appointment.id,
                  meetingTime: timemilist.millisecondsSinceEpoch,
                ),
              ),
            );
          },
          onDateChange: (date) {
            setState(() {
              rescheduleDate = date;
            });
          }),
    );
  }

  // Future<void> goToChatPage({
  //   @required BuildContext context,
  //   @required ChatLobbyResponse chatLobby,
  // }) async {
  //   final userId = await DataSession().getUserId();
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ChatMessagesPage(
  //         chatLobby: chatLobby,
  //         signedInAccountUserId: userId,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildError(BuildContext context, String message) {
    return Container(
      width: SizeConfig.getWidth(context),
      height: SizeConfig.getHeight(context),
      color: Colors.white,
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            height: 1.4,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
        ),
      ),
    );
  }

  Future<double> getDistance(endLatitude, endLongitude) async {
    Position lastPosition = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    if (lastPosition == null) {
      lastPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }
    double startLatitude = lastPosition.latitude;
    double startLongitude = lastPosition.longitude;

    double distanceInMeters = await Geolocator().distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );

    double distanceInKm = (distanceInMeters / 1000);
    return distanceInKm;
  }

  Widget _buildItemTop(AppointmentResponse appointment) {
    double endLatitude = appointment.productDetail.location.latitude;
    double endLongitude = appointment.productDetail.location.longitude;

    return FutureBuilder(
        future: getDistance(endLatitude, endLongitude),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          String distanceRadius = "- Km";
          if (snapshot.data != null) {
            distanceRadius =
                num.parse(snapshot.data.toStringAsExponential(1)).toString() +
                    " Km";
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: (appointment.appointmentUser.avatarUrl == "")
                          ? Container(
                              decoration: BoxDecoration(
                                color: colorDarkBackground,
                                shape: BoxShape.circle,
                              ),
                            )
                          : Image.network(
                              appointment.appointmentUser.avatarUrl,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  radius: 30,
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.appointmentUser.firstName +
                          " " +
                          appointment.appointmentUser.lastName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Poppins",
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: IconTheme(
                              data: IconThemeData(
                                  color: colorDarkBackground, opacity: 0.5),
                              child: Icon(
                                Icons.location_on,
                                size: 14,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: "Hokkaido",
                            style: TextStyle(
                              color: colorDarkBackground,
                              letterSpacing: 1,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: IconTheme(
                          data: IconThemeData(
                              color: colorDarkBackground, opacity: 0.5),
                          child: Icon(
                            Icons.near_me,
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
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _buildItemMiddle(AppointmentResponse appointment) {
    // String dateTimeAppointment = "May 18th, 2020 - 11:05 AM";
    DateFormat appointmentDateFormat = new DateFormat('EEEE, d MMMM yyyy');
    DateFormat appointmentTimeFormat = new DateFormat('H:mm a');

    String dateTimeAppointment =
        appointmentDateFormat.format(appointment.meetingTime) +
            " at " +
            appointmentTimeFormat.format(appointment.meetingTime);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: 100,
            height: 100,
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
                      appointment.productDetail.imgUrl,
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
        ),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appointment.productDetail.name,
                maxLines: 2,
                style: TextStyle(
                  color: colorDarkBackground,
                  letterSpacing: 1,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "¥ ${appointment.productDetail.price}",
                style: TextStyle(
                  color: colorSecondary,
                  letterSpacing: 1,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: "Poppins",
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: IconTheme(
                          data: IconThemeData(
                            color: colorDarkBackground,
                            opacity: 0.5,
                          ),
                          child: Icon(
                            FontAwesomeIcons.calendarAlt,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: dateTimeAppointment,
                      style: TextStyle(
                        color: colorBlueGaijin,
                        letterSpacing: 1,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemUndefined(String message) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(message),
      ),
    );
  }

  Widget _buildChatButton(AppointmentResponse appointment) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, chatState) async {
        dynamic _chatBloc = BlocProvider.of<ChatBloc>(context);
        //TODO fix chat screen navigated twice
        if (chatState.currentChatLobbyResponse != null) {
          // final userId = await DataSession().getUserId();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => ChatMessagesPage(
          //             chatLobby: chatState.currentChatLobbyResponse,
          //             signedInAccountUserId: userId,
          //           )),
          // );
          _chatBloc.add(CloseInitiateChatEvent());
        }
      },
      builder: (context, chatState) {
        dynamic _chatBloc = BlocProvider.of<ChatBloc>(context);
        return RaisedButton(
          elevation: 3.0,
          onPressed: () {
            print("Chat Button Pressed=>${appointment.appointmentUser.id}");
            // BlocProvider.of<AppointmentSellerBloc>(context).add(
            //   GenerateChatRoomEvent(
            //     receiverid: appointment.appointmentUser.id,
            //   ),
            // );
            _chatBloc.add(
              InitiateChatEvent(
                receiverId: appointment.appointmentUser.id,
              ),
            );
          },
          padding: const EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: colorPrimary,
          child: Text(
            'Chat with Buyer',
            style: TextStyle(
              height: 1.4,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemBottomAccepted(
      BuildContext context, AppointmentResponse appointment) {
    DateTime now = DateTime.now();
    DateTime meetingTime = DateTime(
        appointment.meetingTime.year,
        appointment.meetingTime.month,
        appointment.meetingTime.day,
        appointment.meetingTime.hour,
        appointment.meetingTime.minute);
    Duration difference = now.difference(meetingTime);
    String leftTime = timeago.format(now.subtract(difference), locale: 'en');

    // Check whether the date has passed or not
    bool isBefore = (now.isBefore(meetingTime));

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 8.0,
        bottom: 16.0,
      ),
      child: isBefore
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Meet with buyer in: $leftTime",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorTosca,
                    letterSpacing: 1,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: SizeConfig.getWidth(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: RaisedButton(
                          elevation: 3.0,
                          onPressed: () {
                            print("Reschedule Button Pressed");
                            rescheduleAppintment(context, appointment);
                          },
                          padding: const EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: colorSoftDark,
                          child: Text(
                            "Reschedule",
                            style: TextStyle(
                              height: 1.4,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 5,
                        child: RaisedButton(
                          elevation: 3.0,
                          onPressed: null,
                          disabledColor: colorSoftBlue,
                          padding: const EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: colorSoftDark,
                          child: Text(
                            "Accepted",
                            style: TextStyle(
                              height: 1.4,
                              color: colorTosca,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildChatButton(appointment),
              ],
            )
          : Column(
              children: <Widget>[
                Text(
                  "Meet with buyer in: $leftTime",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: colorSecondaryBold,
                    letterSpacing: 1,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: SizeConfig.getWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: RaisedButton(
                          elevation: 3.0,
                          onPressed: () {
                            print("Reschedule Button Pressed");
                            rescheduleAppintment(context, appointment);
                          },
                          padding: const EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: colorSoftDark,
                          child: Text(
                            "Reschedule",
                            style: TextStyle(
                              height: 1.4,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 5,
                        child: RaisedButton(
                          elevation: 3.0,
                          onPressed: () {
                            print("Finish Transaction Button Pressed");
                            CustomDialog.showLoadingDialog(context: context);
                            BlocProvider.of<AppointmentSellerBloc>(context).add(
                              FinishAppointmentEvent(
                                finishAppointmentParam:
                                    FinishAppointmentParam(id: appointment.id),
                              ),
                            );
                          },
                          padding: const EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: colorSecondary,
                          child: Text(
                            "Finish Transaction",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildChatButton(appointment),
              ],
            ),
    );
  }

  Widget _buildItemBottomRejected(
      BuildContext context, AppointmentResponse appointment) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: RaisedButton(
              elevation: 3.0,
              onPressed: () {
                print("Chat with Buyer Button Pressed");
              },
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: colorSoftDark,
              child: Text(
                "Chat with Buyer",
                style: TextStyle(
                  height: 1.4,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Text(
              "Appointment ${appointment.status}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: (appointment.status == "accepted")
                    ? colorTosca
                    : colorSecondary,
                fontSize: 11.0,
                letterSpacing: 1,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemBottomPending(
      BuildContext context, AppointmentResponse appointment) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: RaisedButton(
              elevation: 3.0,
              onPressed: () {
                print("Reject Button Pressed");
              },
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: colorSoftDark,
              child: Text(
                "Reject",
                style: TextStyle(
                  height: 1.4,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: RaisedButton(
              elevation: 3.0,
              onPressed: () {
                print("Accept Button Pressed");
                CustomDialog.showLoadingDialog(context: context);
                BlocProvider.of<AppointmentSellerBloc>(context).add(
                  AcceptNotificationEvent(
                    appointmentId: appointment.id,
                  ),
                );
              },
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: colorSecondary,
              child: Text(
                "Accept Request",
                style: TextStyle(
                  height: 1.4,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemBottomFinished(
      BuildContext context, AppointmentResponse appointment) {
    return Container(
      width: SizeConfig.getWidth(context),
      padding: EdgeInsets.only(left: 16, top: 8.0, right: 16.0, bottom: 16.0),
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconTheme(
                  data: IconThemeData(color: colorTosca, opacity: 0.9),
                  child: Icon(
                    Icons.check,
                    size: 14,
                  ),
                ),
              ),
            ),
            TextSpan(
              text: "Completed",
              style: TextStyle(
                color: colorTosca,
                letterSpacing: 1,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, AppointmentResponse appointment) {
    String status = appointment.status;

    return Container(
      width: SizeConfig.getWidth(context),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildItemTop(appointment),
          _buildItemMiddle(appointment),
          (status == "accepted")
              ? _buildItemBottomAccepted(context, appointment)
              : (status == "rejected")
                  ? _buildItemBottomRejected(context, appointment)
                  : (status == "pending")
                      ? _buildItemBottomPending(context, appointment)
                      : (status == "finished")
                          ? _buildItemBottomFinished(context, appointment)
                          : _buildItemUndefined(
                              "Undefined Status ${appointment.status}"),
          Container(
            width: SizeConfig.getWidth(context),
            color: colorSoftBlue,
            height: 8,
          )
        ],
      ),
    );
  }

  Widget _buildAppointmentHeader(String title) {
    return SliverToBoxAdapter(
      child: Container(
        color: colorSoftBlue,
        padding: EdgeInsets.all(16.0),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildNoDataContainer() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            "No Data Found",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueAccent,
              letterSpacing: 1,
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              fontFamily: "Poppins",
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPendingAppointmentContent(
      BuildContext context, AppointmentSellerResponse state) {
    List<AppointmentResponse> appointments = state.response.data.appointments;
    List<AppointmentResponse> appointmentsPending = [];
    for (var i = 0; i < appointments.length; i++) {
      if (appointments[i].status == "pending") {
        appointmentsPending.add(appointments[i]);
      }
    }

    if (appointmentsPending.length > 0) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _buildItem(context, appointmentsPending[index]);
          },
          childCount: appointmentsPending.length,
        ),
      );
    } else {
      return _buildNoDataContainer();
    }
  }

  Widget _buildAcceptedAppointmentContent(
      BuildContext context, AppointmentSellerResponse state) {
    List<AppointmentResponse> appointments = state.response.data.appointments;
    List<AppointmentResponse> appointmentsAccepted = [];
    for (var i = 0; i < appointments.length; i++) {
      if (appointments[i].status == "accepted") {
        appointmentsAccepted.add(appointments[i]);
      }
    }

    if (appointmentsAccepted.length > 0) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _buildItem(context, appointmentsAccepted[index]);
          },
          childCount: appointmentsAccepted.length,
        ),
      );
    } else {
      return _buildNoDataContainer();
    }
  }

  Widget _buildCompleteAppointmentContent(
      BuildContext context, AppointmentSellerResponse state) {
    List<AppointmentResponse> appointments = state.response.data.appointments;
    List<AppointmentResponse> appointmentsFinished = [];
    for (var i = 0; i < appointments.length; i++) {
      if (appointments[i].status == "finished") {
        appointmentsFinished.add(appointments[i]);
      }
    }

    if (appointmentsFinished.length > 0) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _buildItem(context, appointmentsFinished[index]);
          },
          childCount: appointmentsFinished.length,
        ),
      );
    } else {
      return _buildNoDataContainer();
    }
  }

  Widget _buildRejectedAppointmentContent(
      BuildContext context, AppointmentSellerResponse state) {
    List<AppointmentResponse> appointments = state.response.data.appointments;
    List<AppointmentResponse> appointmentsRejected = [];
    for (var i = 0; i < appointments.length; i++) {
      if (appointments[i].status == "rejected") {
        appointmentsRejected.add(appointments[i]);
      }
    }

    if (appointmentsRejected.length > 0) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _buildItem(context, appointmentsRejected[index]);
          },
          childCount: appointmentsRejected.length,
        ),
      );
    } else {
      return _buildNoDataContainer();
    }
  }

  Widget _buildSpacingArea({@required double height, @required Color color}) {
    return SliverToBoxAdapter(
      child: Container(
        width: SizeConfig.getWidth(context),
        height: height,
        color: color,
      ),
    );
  }

  Widget _buildContent(BuildContext context, AppointmentSellerResponse state) {
    List<AppointmentResponse> appointments = state.response.data.appointments;

    if (appointments.length > 0) {
      return CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          _buildAppointmentHeader("Accepted appointments"),
          _buildAcceptedAppointmentContent(context, state),
          _buildAppointmentHeader("Requested appointments"),
          _buildPendingAppointmentContent(context, state),
          _buildAppointmentHeader("Completed appointments"),
          _buildCompleteAppointmentContent(context, state),
          _buildAppointmentHeader("Rejected appointments"),
          _buildRejectedAppointmentContent(context, state),
          _buildSpacingArea(color: Colors.white, height: 100),
        ],
      );
    } else {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: SizeConfig.getWidth(context),
          height: SizeConfig.getHeight(context),
          color: Colors.white,
          padding: EdgeInsets.only(top: 30.0),
          child: Text(
            "No Data",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 1,
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              fontFamily: "Poppins",
            ),
          ),
        ),
      );
    }
  }

  Widget _buildBody(BuildContext context, AppointmentSellerResponse state) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<AppointmentSellerBloc>(context).add(
          GetSellerAppointmentEvent(),
        );
        return _refreshCompleter.future;
      },
      child: _buildContent(context, state),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentSellerBloc, AppointmentSellerState>(
      listener: (BuildContext context, AppointmentSellerState state) {
        if (state is AppointmentSellerResponse) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }

        if (state is AppointmentConfirmationResponse) {
          CustomDialog.hidePopupDialog(context: context);
          if (state.response.status == "Success") {
            CustomDialog.showSuccessDialog(
              context: context,
              title: state.response.status,
              message: state.response.message,
            );
          } else {
            CustomDialog.showErrorDialog(
              context: context,
              title: state.response.status,
              message: state.response.message,
            );
          }
          BlocProvider.of<AppointmentSellerBloc>(context)
              .add(GetSellerAppointmentEvent());
        }

        if (state is AppointmentFinished) {
          CustomDialog.hidePopupDialog(context: context);
          if (state.response.status == "Success") {
            CustomDialog.showSuccessDialog(
              context: context,
              title: state.response.status,
              message: state.response.message,
            );
          } else {
            CustomDialog.showErrorDialog(
              context: context,
              title: state.response.status,
              message: state.response.message,
            );
          }
          BlocProvider.of<AppointmentSellerBloc>(context).add(
            GetSellerAppointmentEvent(),
          );
        }

        if (state is AppointmentRescheduled) {
          CustomDialog.hidePopupDialog(context: context);
          if (state.response.status == "Success") {
            CustomDialog.showSuccessDialog(
              context: context,
              title: state.response.status,
              message: state.response.message,
            );
          } else {
            CustomDialog.showErrorDialog(
              context: context,
              title: state.response.status,
              message: state.response.message,
            );
          }
          BlocProvider.of<AppointmentSellerBloc>(context).add(
            GetSellerAppointmentEvent(),
          );
        }

        // if (state is InitiateChatResponse) {
        //   String status = state.response.status;
        //   if (status == "Success") {
        //     goToChatPage(
        //       context: context,
        //       chatLobby: state.response.data.room,
        //     );
        //   }
        // }
      },
      builder: (BuildContext context, AppointmentSellerState state) {
        if (state is AppointmentSellerInitial) {
          return IllustrationLoading();
        } else if (state is AppointmentSellerResponse) {
          if (state.response.status == "Success") {
            return _buildBody(context, state);
          } else {
            return _buildError(context, state.response.message);
          }
        } else if (state is AppointmentSellerError) {
          return _buildError(context, state.message);
        }
        return IllustrationLoading();
      },
    );
  }
}
