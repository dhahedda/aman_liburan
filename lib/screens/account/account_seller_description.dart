import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:intl/intl.dart';

class AccountSellerDescription extends StatefulWidget {
  final GlobalResponse response;

  const AccountSellerDescription({Key key, this.response}) : super(key: key);

  @override
  _AccountSellerDescriptionState createState() =>
      _AccountSellerDescriptionState(response);
}

class _AccountSellerDescriptionState extends State<AccountSellerDescription> {
  final GlobalResponse response;

  _AccountSellerDescriptionState(this.response);

  Widget _buildSpacingArea({ @required double height, @required Color color}) {
    return SliverToBoxAdapter(
      child: Container(
        width: SizeConfig.getWidth(context),
        height: height,
        color: color,
      ),
    );
  }

  Widget _buildShortBio(GlobalResponse response) {
    final dateFormat = new DateFormat('dd MMMM yyyy');

    String shortBio     = response.data.userInfo.shortBio;
    DateTime createdAt  = response.data.userInfo.createdAt;

    // String shortBio = "Hello, my name is Gilang. I moved here in Hokkaido for some college stuff, and i’m more of a thrifting-guy than a brand-new. So, i’d like to buy and sell some stuff here. \n\n Hit me up if you find my stuff interesting!";
    // String administrativeArea = "Hokkaido";

    String joinedStatus = "2Gaijins since - "+dateFormat.format(createdAt);

    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Short Bio",
              style: TextStyle(
                color: colorDarkBackground,
                letterSpacing: 1,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              shortBio,
              style: TextStyle(
                color: colorGreyGaijin,
                letterSpacing: 1,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 8.0),
            // RichText(
            //   text: TextSpan(
            //     children: [
            //       WidgetSpan(
            //         child: Padding(
            //           padding: const EdgeInsets.only(right: 4.0, top: 2.0, bottom: 2.0),
            //           child: IconTheme(
            //             data: IconThemeData(
            //                 color: colorDarkBackground, opacity: 0.5),
            //             child: Icon(
            //               FontAwesomeIcons.mapMarkerAlt,
            //               size: 10,
            //             ),
            //           ),
            //         ),
            //       ),
            //       TextSpan(
            //         text: administrativeArea,
            //         style: TextStyle(
            //           color: colorDarkBackground,
            //           letterSpacing: 1,
            //           fontSize: 10.0,
            //           fontWeight: FontWeight.w500,
            //           fontFamily: "Poppins",
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 1.0),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0, top: 2.0, bottom: 2.0),
                      child: IconTheme(
                        data: IconThemeData(
                            color: colorDarkBackground, opacity: 0.5),
                        child: Icon(
                          FontAwesomeIcons.solidClock,
                          size: 10,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: joinedStatus,
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
    );
  }

  Widget _buildBadgeEarned(GlobalResponse response){
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Badge Earned",
              style: TextStyle(
                color: colorDarkBackground,
                letterSpacing: 1,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(
              direction: Axis.horizontal,
              children: <Widget>[
                Image.asset(
                  "assets/images/badge_1.png",
                  width: 48,
                  height: 48,
                ),
                Image.asset(
                  "assets/images/badge_2.png",
                  width: 48,
                  height: 48,
                ),
                Image.asset(
                  "assets/images/badge_3.png",
                  width: 48,
                  height: 48,
                ),
                Image.asset(
                  "assets/images/badge_4.png",
                  width: 48,
                  height: 48,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildTransactionHistory(GlobalResponse response){
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Transaction History",
              style: TextStyle(
                color: colorDarkBackground,
                letterSpacing: 1,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 8.0),
            
          ],
        ),
      ),
    );
  }

  Widget _buildContent(GlobalResponse response) {
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        _buildShortBio(response),
        _buildSpacingArea(color: colorSoftBlue, height: 10),
        _buildBadgeEarned(response),
        _buildSpacingArea(color: colorSoftBlue, height: 10),
        _buildTransactionHistory(response),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(response);
  }
}