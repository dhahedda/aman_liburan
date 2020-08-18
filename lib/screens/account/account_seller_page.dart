import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aman_liburan/blocs/account/account_bloc.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/page.dart';
import 'package:aman_liburan/screens/account/account_seller_collection.dart';
import 'package:aman_liburan/screens/account/account_seller_description.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/custom_sliver_page_header.dart';
import 'package:aman_liburan/utilities/widgets/illustration_loading.dart';

class AccountSellerPage extends StatelessWidget {
  final String userId;
  const AccountSellerPage({Key key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<AccountBloc>(
      create: (context) =>
          AccountBloc()..add(GetSellerAccountEvent(userId: userId)),
      child: AccountSellerScreen());
}

class AccountSellerScreen extends StatefulWidget {
  @override
  _AccountSellerScreenState createState() => _AccountSellerScreenState();
}

class _AccountSellerScreenState extends State<AccountSellerScreen> {
  Completer<void> _refreshCompleter;

  ScrollController _scrollController;
  bool lastStatus = true;

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (150 - kToolbarHeight);
  }

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _refreshCompleter.complete();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
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

  Widget _buildHeader(GlobalResponse response, AccountState state) {
    String userName = response.data.userInfo.firstName;
    String goldCoin = "${response.data.userInfo.goldCoin} gold";
    String silverCoin = "${response.data.userInfo.silverCoin} silver";
    String avatarSeller = response.data.userInfo.avatarUrl;

    // String administrativeArea = "Unknown Location";
    // if (state.placemarks[0].name != "unknown_location") {
    //   administrativeArea = state.placemarks[0].administrativeArea;
    // }

    return SafeArea(
      child: Wrap(
        direction: Axis.vertical,
        children: [
          Container(
            width: SizeConfig.getWidth(context),
            height: 160,
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: colorPrimary,
                              ),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      Center(
                        child: (avatarSeller == "")
                            ? Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    color: colorDarkBackground,
                                    shape: BoxShape.circle),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    360.0,
                                  ),
                                ),
                                child: Image.network(
                                  avatarSeller,
                                  fit: BoxFit.cover,
                                  width: 120.0,
                                  height: 120.0,
                                ),
                              ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          color: colorDarkBackground,
                          letterSpacing: 1,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Nunito",
                        ),
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //     children: [
                      //       WidgetSpan(
                      //         child: IconTheme(
                      //           data: IconThemeData(
                      //               color: colorDarkBackground, opacity: 0.5),
                      //           child: Icon(
                      //             Icons.location_on,
                      //             size: 14,
                      //           ),
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: administrativeArea,
                      //         style: TextStyle(
                      //           color: colorDarkBackground,
                      //           letterSpacing: 1,
                      //           fontSize: 14.0,
                      //           fontWeight: FontWeight.w500,
                      //           fontFamily: "Nunito",
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Gold Point
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: IconTheme(
                                      data: IconThemeData(
                                          color: colorDarkBackground,
                                          opacity: 0.5),
                                      child: Image.asset(
                                        "assets/images/gold_coin.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: goldCoin,
                                    style: TextStyle(
                                      color: colorDarkBackground,
                                      letterSpacing: 1,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0),
                            // Silver Point
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: IconTheme(
                                      data: IconThemeData(
                                          color: colorDarkBackground,
                                          opacity: 0.5),
                                      child: Image.asset(
                                        "assets/images/silver_coin.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: silverCoin,
                                    style: TextStyle(
                                      color: colorDarkBackground,
                                      letterSpacing: 1,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 8,
                            child: RaisedButton(
                              elevation: 5.0,
                              onPressed: () {
                                print("Chat Button Pressed");
                              },
                              padding: const EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              color: colorSoftDark,
                              child: Text(
                                'Chat with Owner',
                                style: TextStyle(
                                  color: colorDarkBackground,
                                  letterSpacing: 1,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 2,
                            child: ButtonTheme(
                              minWidth: 40.0,
                              child: RaisedButton(
                                  elevation: 5.0,
                                  onPressed: () {
                                    print("Icon Plus Button Pressed");
                                  },
                                  padding: const EdgeInsets.all(10.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  color: Colors.blue,
                                  child: IconTheme(
                                    data: IconThemeData(
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 14,
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(width: 16.0),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(GlobalResponse response, AccountState state) {
    return SliverAppBar(
      snap: false,
      pinned: true,
      floating: false,
      expandedHeight: 160.0,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(background: _buildHeader(response, state)),
      centerTitle: true,
      title: Visibility(
        visible: isShrink ? true : false,
        child: Text(
          "Profile Page",
          textAlign: TextAlign.center,
          style: TextStyle(color: colorPrimary),
        ),
      ),
      leading: Opacity(
        opacity: isShrink ? 1.0 : 0.4,
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: colorPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AccountState state) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          key: PageStorageKey(BottomPage.page_4),
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _buildSliverAppBar(state.response, state),
              SliverPersistentHeader(
                delegate: CustomSliverPageHeader(
                  minHeight: 60,
                  maxHeight: 60,
                  child: PreferredSize(
                    preferredSize: Size.fromHeight(70),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: TabBar(
                          indicatorColor: colorPrimary,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: colorBlueGaijin,
                          unselectedLabelColor: colorBlueGaijin80,
                          indicator: UnderlineTabIndicator(
                            borderSide:
                                BorderSide(color: colorBlueGaijin, width: 2),
                            insets: EdgeInsets.symmetric(horizontal: 80),
                          ),
                          tabs: [
                            Tab(
                              child: Text(
                                "Collections",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Desription",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              // Collections
              AccountSellerCollection(response: state.response),

              // Description
              AccountSellerDescription(response: state.response),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (BuildContext context, AccountState state) {
        if (state is AccountResponse) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }
      },
      builder: (BuildContext context, AccountState state) {
        if (state is AccountLoading) {
          return IllustrationLoading();
        } else if (state is AccountResponse) {
          if (state.response.status == "Success") {
            return _buildBody(context, state);
          } else {
            return _buildError(context, state.response.message);
          }
        } else if (state is AccountError) {
          return _buildError(context, state.message);
        }
        return IllustrationLoading();
      },
    );
  }
}
