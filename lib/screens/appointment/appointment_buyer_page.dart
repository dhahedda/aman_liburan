import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:aman_liburan/blocs/appointment_buyer/appointment_buyer_bloc.dart';
import 'package:aman_liburan/blocs/chat/chat_bloc.dart';
import 'package:aman_liburan/components/data_session.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/illustration_loading.dart';
import 'package:timeago/timeago.dart' as timeago;

class AppointmentBuyerPage extends StatefulWidget {
  @override
  _AppointmentBuyerPageState createState() => _AppointmentBuyerPageState();
}

class _AppointmentBuyerPageState extends State<AppointmentBuyerPage> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  Future<void> goToChatPage({
    @required BuildContext context,
    @required ChatLobbyResponse chatLobby,
  }) async {
    final userId = await DataSession().getUserId();
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ChatMessagesPage(
    //       chatLobby: chatLobby,
    //       signedInAccountUserId: userId,
    //     ),
    //   ),
    // );
  }

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

  Widget _buildItemTop(AppointmentResponse appointment) {
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
                    data:
                        IconThemeData(color: colorDarkBackground, opacity: 0.5),
                    child: Icon(
                      Icons.near_me,
                      size: 14,
                    ),
                  ),
                ),
                TextSpan(
                  text: "12 Km",
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
              children: [
                Text(
                  "Your appointment request has been accepted",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
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
                    color: colorSoftDark,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Meet with seller in: $leftTime",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: colorDarkBackground,
                          letterSpacing: 1,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildChatButton(appointment, true),
                    // Expanded(
                    //   child: RaisedButton(
                    //     elevation: 3.0,
                    //     onPressed: () {
                    //       print("Chat Button Pressed");
                    //       BlocProvider.of<AppointmentBuyerBloc>(context).add(
                    //         GenerateChatRoomEvent(
                    //           receiverid: appointment.appointmentUser.id,
                    //         ),
                    //       );
                    //     },
                    //     padding: const EdgeInsets.all(10.0),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     color: colorSecondary,
                    //     child: Text(
                    //       "Chat with Seller",
                    //       style: TextStyle(
                    //         height: 1.4,
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 12.0,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Your appointment request has been accepted",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
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
                    color: colorSoftDark,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Meet with seller in: $leftTime",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: colorSecondaryBold,
                          letterSpacing: 1,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        elevation: 3.0,
                        onPressed: () {
                          print("Chat Button Pressed");
                          BlocProvider.of<AppointmentBuyerBloc>(context).add(
                            GenerateChatRoomEvent(
                              receiverid: appointment.appointmentUser.id,
                            ),
                          );
                        },
                        padding: const EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: colorSecondary,
                        child: Text(
                          "Chat with Seller",
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
              ],
            ),
    );
  }

  Widget _buildItemBottomRejected(
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
                  data: IconThemeData(color: colorSecondary, opacity: 0.9),
                  child: Icon(
                    Icons.close,
                    size: 14,
                  ),
                ),
              ),
            ),
            TextSpan(
              text: "This appointment is rejected",
              style: TextStyle(
                color: colorSecondary,
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

  Widget _buildChatButton(AppointmentResponse appointment, bool isOrange) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, chatState) async {
        dynamic _chatBloc = BlocProvider.of<ChatBloc>(context);
        if (chatState.currentChatLobbyResponse != null) {
          final userId = await DataSession().getUserId();
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
        return Expanded(
          child: RaisedButton(
            elevation: 3.0,
            onPressed: () {
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
            color: isOrange ? colorSecondary : colorSoftDark,
            child: Text(
              "Chat with Seller",
              style: TextStyle(
                height: 1.4,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        );
      },
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
          _buildChatButton(appointment, false),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "In-review..",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorSecondary,
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
      BuildContext context, AppointmentBuyerResponse state) {
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
      BuildContext context, AppointmentBuyerResponse state) {
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
      BuildContext context, AppointmentBuyerResponse state) {
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
      BuildContext context, AppointmentBuyerResponse state) {
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

  Widget _buildContent(BuildContext context, AppointmentBuyerResponse state) {
    List<AppointmentResponse> appointments = state.response.data.appointments;
    if (appointments.length > 0) {
      return CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          _buildAppointmentHeader("Accepted Transactions"),
          _buildAcceptedAppointmentContent(context, state),
          _buildAppointmentHeader("Your appointments"),
          _buildPendingAppointmentContent(context, state),
          _buildAppointmentHeader("Completed Transactions"),
          _buildCompleteAppointmentContent(context, state),
          _buildAppointmentHeader("Rejected Transactions"),
          _buildRejectedAppointmentContent(context, state),
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

  Widget _buildBody(BuildContext context, AppointmentBuyerResponse state) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<AppointmentBuyerBloc>(context).add(
          GetBuyerAppointmentEvent(),
        );
        return _refreshCompleter.future;
      },
      child: _buildContent(context, state),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentBuyerBloc, AppointmentBuyerState>(
      listener: (BuildContext context, AppointmentBuyerState state) {
        if (state is AppointmentBuyerResponse) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }

        if (state is InitiateChatResponse) {
          String status = state.response.status;
          if (status == "Success") {
            goToChatPage(
              context: context,
              chatLobby: state.response.data.room,
            );
          }
        }
      },
      builder: (BuildContext context, AppointmentBuyerState state) {
        if (state is AppointmentBuyerInitial) {
          return IllustrationLoading();
        } else if (state is AppointmentBuyerResponse) {
          if (state.response.status == "Success") {
            return _buildBody(context, state);
          } else {
            return _buildError(context, state.response.message);
          }
        } else if (state is AppointmentBuyerError) {
          return _buildError(context, state.message);
        }
        return IllustrationLoading();
      },
    );
  }
}
