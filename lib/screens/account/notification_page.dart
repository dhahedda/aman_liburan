import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:aman_liburan/blocs/notification/notification_bloc.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/screens/account/send_tip_dialog_page.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/custom_dialog.dart';
import 'dart:ui' as ui show PlaceholderAlignment;

import 'package:aman_liburan/utilities/widgets/illustration_loading.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<NotificationBloc>(
        create: (context) => NotificationBloc()..add(GetNotificationEvent()),
        child: NotificationPageScreen(),
      );
}

class NotificationPageScreen extends StatefulWidget {
  @override
  _NotificationPageScreenState createState() => _NotificationPageScreenState();
}

class _NotificationPageScreenState extends State<NotificationPageScreen> {
  Completer<void> _refreshCompleter;
  bool isGoldCoin = true;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
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

  Widget _buildItemTop(NotificationResponse notificationResponse) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: (notificationResponse.notificationUser.avatarUrl == "")
                ? Container(
                    width: 32,
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: colorDarkBackground,
                      shape: BoxShape.circle,
                    ),
                  )
                : Container(
                    width: 32,
                    height: 32.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            notificationResponse.notificationUser.avatarUrl),
                      ),
                    ),
                  ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationResponse.notificationUser.firstName +
                      " " +
                      notificationResponse.notificationUser.lastName,
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
      ),
    );
  }

  Widget _buildItemMiddle(NotificationResponse notificationResponse) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: colorSoftDark,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
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
                          notificationResponse.product.imgUrl,
                          fit: BoxFit.cover,
                          width: 100.0,
                        ),
                      ),
                    ),
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
                    notificationResponse.product.name,
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
                    "¥ ${notificationResponse.product.price}",
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
                          child: IconTheme(
                            data: IconThemeData(
                              color: colorDarkBackground,
                              opacity: 0.5,
                            ),
                            child: Icon(
                              Icons.calendar_today,
                              size: 14,
                            ),
                          ),
                        ),
                        TextSpan(
                          // text: "May 18th, 2020 - 11:05 AM",
                          text: DateFormat('MMM d, y – h:m a').format(
                              notificationResponse.appointment.meetingTime),
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
        ),
      ),
    );
  }

  // For handling info as rejected or accepted (if status 'accepted' or 'rejected')
  Widget _buildItemBottomInfo(NotificationResponse notificationResponse) {
    // Notes: order_incoming (notification for seller), appointment_confirmation (notification for buyer)
    String typeNotification = notificationResponse.type;
    String buttonChatText = "";
    if (typeNotification == "order_incoming") {
      buttonChatText = "Chat with Buyer";
    } else {
      buttonChatText = "Chat with Seller";
    }

    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: RaisedButton(
              elevation: 3.0,
              onPressed: () {
                print("$buttonChatText Button Pressed");
                CustomDialog.showInfoDialog(
                  context: context,
                  title: buttonChatText,
                  message: "$buttonChatText Button Pressed!",
                );
              },
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: colorSoftDark,
              child: Text(
                buttonChatText,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 11.0,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w800,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Text(
              "Appointment ${notificationResponse.status}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: (notificationResponse.status == "accepted")
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

  // For handling reject or accept appointment (For Seller User)
  Widget _buildItemBottomActionForSeller(
      NotificationResponse notificationResponse) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: RaisedButton(
              elevation: 3.0,
              onPressed: () {
                print("Reject Button Pressed");
                CustomDialog.showLoadingDialog(context: context);
                BlocProvider.of<NotificationBloc>(context).add(
                  RejectNotificationEvent(
                    appointmentId: notificationResponse.appointmentId,
                  ),
                );
              },
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: colorSoftDark,
              child: Text(
                "Reject",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 11.0,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w800,
                  fontFamily: "Poppins",
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
                BlocProvider.of<NotificationBloc>(context).add(
                  AcceptNotificationEvent(
                    appointmentId: notificationResponse.appointmentId,
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
                  color: Colors.white,
                  fontSize: 11.0,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w800,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ),
        ],
      ),
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

  // jika status pending, penjual bisa melakukan reject atau accept appointment
  Widget _buildIncomingOrder(NotificationResponse notificationResponse) {
    String status = notificationResponse.status;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildItemTop(notificationResponse),
        _buildItemMiddle(notificationResponse),
        (status == "accepted")
            ? _buildItemBottomInfo(notificationResponse)
            : (status == "rejected")
                ? _buildItemBottomInfo(notificationResponse)
                : (status == "pending")
                    ? _buildItemBottomActionForSeller(notificationResponse)
                    : _buildItemUndefined(
                        "Undefined Status ${notificationResponse.status} on ${notificationResponse.type}")
      ],
    );
  }

  Widget _buildItemSilver(NotificationResponse notificationResponse) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: (notificationResponse.notificationUser.avatarUrl == "")
                ? Container(
                    width: 32,
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: colorDarkBackground,
                      shape: BoxShape.circle,
                    ),
                  )
                : Container(
                    width: 32,
                    height: 32.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            notificationResponse.notificationUser.avatarUrl),
                      ),
                    ),
                  ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 9,
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: <Widget>[
                Text(
                  notificationResponse.notificationUser.firstName +
                      " " +
                      notificationResponse.notificationUser.lastName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  ", Just gave you a ",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        alignment: ui.PlaceholderAlignment.middle,
                        child: IconTheme(
                          data: IconThemeData(
                              color: colorDarkBackground, opacity: 0.5),
                          child: Image.asset(
                            "assets/images/silver.png",
                            width: 12,
                            height: 12,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: " Silver Tip.",
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  " Fancy!",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  " don’t forget to say thank you :)",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemGold(NotificationResponse notificationResponse) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: (notificationResponse.notificationUser.avatarUrl == "")
                ? Container(
                    width: 32,
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: colorDarkBackground,
                      shape: BoxShape.circle,
                    ),
                  )
                : Container(
                    width: 32,
                    height: 32.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            notificationResponse.notificationUser.avatarUrl),
                      ),
                    ),
                  ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 9,
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: <Widget>[
                Text(
                  notificationResponse.notificationUser.firstName +
                      " " +
                      notificationResponse.notificationUser.lastName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  ", Just gave you a ",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        alignment: ui.PlaceholderAlignment.middle,
                        child: IconTheme(
                          data: IconThemeData(
                              color: colorDarkBackground, opacity: 0.5),
                          child: Image.asset(
                            "assets/images/gold.png",
                            width: 12,
                            height: 12,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: " Gold Tip.",
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  " Fancy!",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  " don’t forget to say thank you :)",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // jika status pending, pembeli bisa melakukan chat atau cancel appointment
  Widget _buildAppointmentConfirmation(
      NotificationResponse notificationResponse) {
    String status = notificationResponse.status;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        (status == "silver")
            ? _buildItemSilver(notificationResponse)
            : (status == "gold")
                ? _buildItemGold(notificationResponse)
                : _buildItemUndefined(
                    "Undefined Status ${notificationResponse.status} on ${notificationResponse.type}")
      ],
    );
  }

  Future<void> trustCoinModal(
    BuildContext context,
    NotificationResponse notificationResponse,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => SendTipDialogPage(
          notificationResponse: notificationResponse,
          onSubmitTrustCoin: () {
            print("Ok Submitted => $isGoldCoin");
            String typeCoin = '';
            if (isGoldCoin) {
              typeCoin = 'gold';
            } else {
              typeCoin = 'silver';
            }

            Navigator.pop(context);
            CustomDialog.showLoadingDialog(context: context);
            BlocProvider.of<NotificationBloc>(context).add(
              SendTrustCoinEvent(
                param: SendTrustCoinParam(
                  type: typeCoin,
                  receiverId: notificationResponse.notifierId,
                  appointmentId: notificationResponse.appointmentId,
                ),
              ),
            );
          },
          onIsGoldChange: (bool goldCoin) {
            // print("GoldCoin Changed => $goldCoin");
            setState(() {
              isGoldCoin = goldCoin;
            });
          }),
    );
  }

  Widget _buildGiveTrustCoinTop(
      BuildContext context, NotificationResponse notificationResponse) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: (notificationResponse.notificationUser.avatarUrl == "")
                ? Container(
                    width: 32,
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: colorDarkBackground,
                      shape: BoxShape.circle,
                    ),
                  )
                : Container(
                    width: 32,
                    height: 32.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            notificationResponse.notificationUser.avatarUrl),
                      ),
                    ),
                  ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationResponse.notificationUser.firstName +
                      " " +
                      notificationResponse.notificationUser.lastName,
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
                Text(
                  notificationResponse.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGiveTrustCoinBottom(
    BuildContext context,
    NotificationResponse notificationResponse,
  ) {
    String status = notificationResponse.status;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (status == "finished")
                    ? SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 3.0,
                          disabledColor: colorSecondary.withOpacity(0.5),
                          onPressed: null,
                          padding: const EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: colorSecondary,
                          child: Text(
                            "Coin Sent",
                            style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 3.0,
                          onPressed: () {
                            print("Send Tip Button Pressed");
                            trustCoinModal(context, notificationResponse);
                          },
                          padding: const EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: colorSecondary,
                          child: Text(
                            "Send Tip",
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
          ),
        ],
      ),
    );
  }

  Widget _buildGiveTrustCoin(
      BuildContext context, NotificationResponse notificationResponse) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildGiveTrustCoinTop(context, notificationResponse),
        _buildGiveTrustCoinBottom(context, notificationResponse),
      ],
    );
  }

  Widget _buildTrustCoinSentDetail(
      BuildContext context, NotificationResponse notificationResponse) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: (notificationResponse.notificationUser.avatarUrl == "")
                ? Container(
                    width: 32,
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: colorDarkBackground,
                      shape: BoxShape.circle,
                    ),
                  )
                : Container(
                    width: 32,
                    height: 32.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            notificationResponse.notificationUser.avatarUrl),
                      ),
                    ),
                  ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationResponse.notificationUser.firstName +
                      " " +
                      notificationResponse.notificationUser.lastName,
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
                Text(
                  notificationResponse.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustCoinSent(
      BuildContext context, NotificationResponse notificationResponse) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTrustCoinSentDetail(context, notificationResponse),
      ],
    );
  }

  Widget _buildItem(
      BuildContext context, NotificationResponse notificationResponse) {
    String type = notificationResponse.type;

    return Container(
      width: SizeConfig.getWidth(context),
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 5),
      child: (type == "order_incoming")
          ? _buildIncomingOrder(notificationResponse)
          : (type == "give_trust_coin")
              ? _buildGiveTrustCoin(context, notificationResponse)
              : (type == "appointment_confirmation")
                  ? _buildTrustCoinSent(context, notificationResponse)
                  : (type == "trust_coin_sent")
                      ? _buildAppointmentConfirmation(notificationResponse)
                      : _buildItemUndefined(
                          "Undefined Type ${notificationResponse.type}"),
    );
  }

  Widget _buildContent(BuildContext context, NotificationResponseState state) {
    List<NotificationResponse> notifications =
        state.response.data.notifications;

    if (notifications.length > 0) {
      return CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildItem(context, notifications[index]);
              },
              childCount: notifications.length,
            ),
          ),
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

  Widget _buildBody(BuildContext context, NotificationResponseState state) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<NotificationBloc>(context).add(GetNotificationEvent());
        return _refreshCompleter.future;
      },
      child: Container(
        width: SizeConfig.getWidth(context),
        height: SizeConfig.getHeight(context),
        color: colorSoftBlue,
        child: _buildContent(context, state),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: colorDarkBackground,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        "Notifications",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          letterSpacing: 1,
          fontSize: 14.0,
          fontWeight: FontWeight.w800,
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (BuildContext context, NotificationState state) {
          if (state is NotificationResponseState) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }

          if (state is NotificationConfirmationResponse) {
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
            BlocProvider.of<NotificationBloc>(context)
                .add(GetNotificationEvent());
          }
        },
        builder: (BuildContext context, NotificationState state) {
          if (state is NotificationInitial) {
          return IllustrationLoading();
          } else if (state is NotificationResponseState) {
            if (state.response.status == "Success") {
              return _buildBody(context, state);
            } else {
              return _buildError(context, state.response.message);
            }
          } else if (state is NotificationError) {
            return _buildError(context, state.message);
          }
          return IllustrationLoading();
        },
      ),
    );
  }
}
