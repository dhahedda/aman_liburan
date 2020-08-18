import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:aman_liburan/app_base_configuration.dart';
import 'package:aman_liburan/blocs/account/account_bloc.dart';
import 'package:aman_liburan/components/data_session.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/models/subscription_model.dart';
import 'package:aman_liburan/page.dart';
import 'package:aman_liburan/screens/account/account_seller_page.dart';
import 'package:aman_liburan/screens/account/become_member_dialog_page.dart';
import 'package:aman_liburan/screens/detail_product/product_list.dart';
import 'package:aman_liburan/screens/signin/signin_page.dart';
import 'package:aman_liburan/screens/payment_method/payment_method_page.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/custom_dialog.dart';
import 'package:aman_liburan/utilities/widgets/horizontal_line.dart';
import 'package:aman_liburan/utilities/widgets/illustration_loading.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class AccountPage extends StatelessWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<AccountBloc>(
      create: (context) => AccountBloc()..add(GetAccountEvent()),
      child: AccountScreen());
}

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _birthDayController = TextEditingController();
  TextEditingController _shortBioController = TextEditingController();
  TextEditingController _payPalController = TextEditingController();
  TextEditingController _weChatController = TextEditingController();
  TextEditingController _bankAccountNumberController = TextEditingController();
  TextEditingController _bankAccountNameController = TextEditingController();
  TextEditingController _bankNameController = TextEditingController();

  Completer<void> _refreshCompleter;
  SubscriptionModel subscriptionModel;
  bool notificationAppointment = true;
  bool notificationMessages = true;
  bool notificationLikes = true;

  ScrollController _scrollController;
  bool lastStatus = true;

  bool isSubscribed;
  bool isFromAddProduct;

  final dateFormat = new DateFormat('dd-MM-yyyy');

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (150 - kToolbarHeight);
  }

  _setDefaultProfileValue(GlobalResponse response) {
    String firstName = response.data.profile.firstName;
    String lastName = response.data.profile.lastName;
    String email = response.data.profile.email;
    String phone = response.data.profile.phone;
    DateTime birthDay = response.data.profile.dateOfBirth;
    String shortBio = response.data.profile.shortBio;

    _firstNameController.text = firstName;
    _lastNameController.text = lastName;
    _emailController.text = email;
    _phoneNumberController.text = phone;
    _birthDayController.text = dateFormat.format(birthDay);
    _shortBioController.text = shortBio;
  }

  _setDefaultPaymentValue(GlobalResponse response) {
    String payPal = response.data.paymentMethod.paypal;
    String weChat = response.data.paymentMethod.wechat;
    String bankAccountNumber = response.data.paymentMethod.bankAccountNumber;
    String bankAccountName = response.data.paymentMethod.bankAccountName;
    String bankName = response.data.paymentMethod.bankName;

    _payPalController.text = payPal;
    _weChatController.text = weChat;
    _bankAccountNumberController.text = bankAccountNumber;
    _bankAccountNameController.text = bankAccountName;
    _bankNameController.text = bankName;
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

  Future<void> becomeMemberModal(
    BuildContext context,
    GlobalResponse response,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BecomeMemberDialogPage(
        globalResponseParam: response,
        onSubmitSubscription: () {
          Navigator.pop(context);
          print("subscriptionModel => ${subscriptionModel.price}");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentMethodPage(subscriptionModel: subscriptionModel),
            ),
          );
        },
        onStateSubscriptionChange: (stateSubscription) {
          setState(
            () {
              subscriptionModel = stateSubscription;
              // print("subscriptionModel => ${subscriptionModel.price}");
            },
          );
        },
      ),
    );
  }

  Future<Null> _selectBirtDay(BuildContext context) async {
    DateTime selectedDate = dateFormat.parse(_birthDayController.text);
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      _birthDayController.text = dateFormat.format(picked);
    }
  }

  Future<void> goToLoginPage(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 2000));
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return SigninPage();
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
      (Route route) => false,
    );
  }

  Widget _showError(String message) {
    return Container(
      width: SizeConfig.getWidth(context),
      height: SizeConfig.getHeight(context),
      child: Center(child: Text(message)),
    );
  }

  Widget _buildHeader(GlobalResponse response, AccountState state) {
    String userName =
        response.data.profile.firstName + " " + response.data.profile.lastName;
    String goldCoin = response.data.profile.goldCoin.toString() + " gold";
    String silverCoin = response.data.profile.silverCoin.toString() + " silver";
    String avatarSeller = response.data.profile.avatarUrl;

    String administrativeArea = "Unknown Location";
    if (state.placemarks[0].name != "unknown_location") {
      administrativeArea = state.placemarks[0].administrativeArea;
    }

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
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      Center(
                        child: (avatarSeller == "")
                            ? Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: colorDarkBackground,
                                  shape: BoxShape.circle,
                                ),
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
                      ),
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
                                  Icons.location_on,
                                  size: 14,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: administrativeArea,
                              style: TextStyle(
                                color: colorDarkBackground,
                                letterSpacing: 1,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                        opacity: 0.5,
                                      ),
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
                                      fontFamily: "Poppins",
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
                                        opacity: 0.5,
                                      ),
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
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: RaisedButton(
                                elevation: 5.0,
                                onPressed: () {
                                  print("Preview My Profile Button Pressed");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AccountSellerPage(
                                        userId: response.data.profile.id,
                                      ),
                                    ),
                                  );
                                },
                                padding: const EdgeInsets.all(10.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                color: colorSoftDark,
                                child: Text(
                                  'Preview My Profile',
                                  style: TextStyle(
                                    color: colorDarkBackground,
                                    letterSpacing: 1,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
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
      flexibleSpace:
          FlexibleSpaceBar(background: _buildHeader(response, state)),
      centerTitle: true,
      title: Visibility(
        visible: isShrink ? true : false,
        child: Text(
          "Profile Page",
          textAlign: TextAlign.center,
          style: TextStyle(color: colorPrimary),
        ),
      ),
      // leading: Opacity(
      //   opacity: isShrink ? 1.0 : 0.4,
      //   child: IconButton(
      //     icon: Icon(Icons.arrow_back, color: colorPrimary),
      //     onPressed: () => Navigator.of(context)
      //         .pushReplacementNamed('/app-base-configuration'),
      //   ),
      // ),
    );
  }

  Widget _buildWidgetHeader(String title) {
    return SliverToBoxAdapter(
      child: Container(
        width: SizeConfig.getWidth(context),
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

  Widget _buildAddNewProductButton(
    GlobalResponse response,
    AccountState state,
  ) {
    return RaisedButton(
      elevation: 5.0,
      onPressed: () {
        print("Add Product Button Pressed");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => AppBaseConfiguration(
                  page: BottomPage.page_1,
                )));
      },
      padding: const EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Theme.Colors.turqoiseNormal,
      child: Text(
        '+ Add Product',
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildBecomeMemberButton(
    GlobalResponse response,
    AccountState state,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RaisedButton(
          elevation: 5.0,
          onPressed: () {
            print("Become 2Gaijin member Button Pressed");
            becomeMemberModal(context, response);
          },
          padding: const EdgeInsets.all(12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Theme.Colors.turqoiseNormal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.Colors.turqoiseNormal,
                      borderRadius: BorderRadius.all(Radius.circular(360.0)),
                      shape: BoxShape.rectangle,
                    ),
                    child: Image.asset(
                      "assets/images/bottom_navigation/aman_liburan.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Become 2Gaijin member',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      'and start selling your items today',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        letterSpacing: 1,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '* Your items still presents even after your subscription has ended',
            style: TextStyle(
              color: colorGreyGaijin,
              letterSpacing: 1,
              fontSize: 9.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildYourCollection(GlobalResponse response, AccountState state) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProductListPage()));
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Image.asset(
                  "assets/images/your_collection.png",
                  width: 48,
                  height: 48,
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Your Collections",
                      style: TextStyle(
                        color: colorDarkBackground,
                        letterSpacing: 1,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Poppins",
                      ),
                    ),
                    Text(
                      "View and Manage all collections",
                      style: TextStyle(
                        color: colorGreyGaijin,
                        letterSpacing: 1,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionDraft(GlobalResponse response, AccountState state) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.asset(
              "assets/images/collection_draft.png",
              width: 48,
              height: 48,
            ),
          ),
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Collection Drafts",
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  "Finish your collection’s filling",
                  style: TextStyle(
                    color: colorGreyGaijin,
                    letterSpacing: 1,
                    fontSize: 12.0,
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

  Widget _buildHelpCenter(GlobalResponse response, AccountState state) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.asset(
              "assets/images/help_center.png",
              width: 48,
              height: 48,
            ),
          ),
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Help Center",
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  "Don’t know where to start? we can help",
                  style: TextStyle(
                    color: colorGreyGaijin,
                    letterSpacing: 1,
                    fontSize: 12.0,
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

  Widget _buildCollectionsContent(GlobalResponse response, AccountState state) {
    return SliverToBoxAdapter(
      child: Container(
        width: SizeConfig.getWidth(context),
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildBecomeMemberButton(response, state),
            _buildAddNewProductButton(response, state),
            SizedBox(height: 10.0),
            _buildYourCollection(response, state),
            HorizontalLine(
              width: 100,
              color: colorSoftBlue,
              padding: 10,
            ),
            _buildCollectionDraft(response, state),
            HorizontalLine(
              width: 100,
              color: colorSoftBlue,
              padding: 10,
            ),
            _buildHelpCenter(response, state),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInformation(
    GlobalResponse response,
    AccountState state,
  ) {
    return SliverToBoxAdapter(
      child: Container(
        width: SizeConfig.getWidth(context),
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Personal Information",
              style: TextStyle(
                color: colorDarkBackground,
                letterSpacing: 1,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 10),

            // First Name
            Text(
              "First Name",
              style: TextStyle(
                color: colorDarkBackground,
                letterSpacing: 1,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _firstNameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'First name',
                contentPadding: EdgeInsets.only(left: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Last Name
            Text(
              "Last Name",
              style: TextStyle(
                color: colorDarkBackground,
                letterSpacing: 1,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _lastNameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'Last name',
                contentPadding: EdgeInsets.only(left: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Email Address
            Text(
              "Email Address",
              style: TextStyle(
                color: colorDarkBackground,
                letterSpacing: 1,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'Email Address',
                contentPadding: EdgeInsets.only(left: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Phone Number
            Text(
              "Phone Number",
              style: TextStyle(
                color: colorDarkBackground,
                letterSpacing: 1,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                contentPadding: EdgeInsets.only(left: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Birthday
            Text(
              "Birthday",
              style: TextStyle(
                color: colorDarkBackground,
                letterSpacing: 1,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 4),
            TextField(
              controller: _birthDayController,
              readOnly: true,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'Birthday',
                contentPadding: EdgeInsets.only(left: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(FontAwesomeIcons.calendarAlt, color: colorPrimary),
                  onPressed: () {
                    _selectBirtDay(context);
                  },
                ),
              ),
            ),
            SizedBox(height: 10),

            // Short Bio
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
            SizedBox(height: 4),
            TextFormField(
              controller: _shortBioController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'Describe your self here',
                contentPadding: EdgeInsets.only(left: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: Icon(
                  Icons.arrow_forward_ios,
                  color: colorGreyGaijin,
                ),
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              elevation: 5.0,
              onPressed: () {
                print("Update Profile Button Pressed");
                DateTime dateOfBirth =
                    dateFormat.parse(_birthDayController.text);
                var timemilist = new DateTime.utc(
                  dateOfBirth.year,
                  dateOfBirth.month,
                  dateOfBirth.day,
                ).toUtc();

                UpdateProfileParam param = UpdateProfileParam();
                param.firstName = _firstNameController.text;
                param.lastName = _lastNameController.text;
                param.email = _emailController.text;
                param.phone = _phoneNumberController.text;
                param.dateOfBirth = timemilist.millisecondsSinceEpoch;
                param.shortBio = _shortBioController.text;

                CustomDialog.showLoadingDialog(context: context);
                BlocProvider.of<AccountBloc>(context).add(
                  UpdateProfileEvent(updateProfileParam: param),
                );
              },
              padding: const EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: colorPrimary,
              child: Text(
                'Update Profile',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildYourLocation(GlobalResponse response, AccountState state) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Your Location
            Text(
              "Your Location",
              style: TextStyle(
                color: colorDarkBackground,
                letterSpacing: 1,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 4),
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'Your Location',
                contentPadding: EdgeInsets.only(left: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: Icon(
                  Icons.arrow_forward_ios,
                  color: colorGreyGaijin,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '+ Add location',
              style: TextStyle(
                color: Theme.Colors.turqoiseNormal,
                letterSpacing: 1,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(
    GlobalResponse response,
    AccountState state,
  ) {
    return SliverToBoxAdapter(
      child: FutureBuilder(
        future: _setDefaultPaymentValue(state.response),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            width: SizeConfig.getWidth(context),
            color: Colors.white,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Available Payment Method",
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 10),

                // PayPal
                Text(
                  "PayPal",
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: _payPalController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Enter your PayPal Account Link',
                    contentPadding: EdgeInsets.only(left: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // WeChat
                Text(
                  "WeChat",
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: _weChatController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Enter your WeChat Account ID',
                    contentPadding: EdgeInsets.only(left: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Bank Account Number
                Text(
                  "Bank Account Number",
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: _bankAccountNumberController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Enter your Account Number',
                    contentPadding: EdgeInsets.only(left: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Bank Account Holder's Name
                Text(
                  "Bank Account Holder's Name",
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: _bankAccountNameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Enter your Bank Account Name',
                    contentPadding: EdgeInsets.only(left: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Bank Name
                Text(
                  "Bank Name",
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: _bankNameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Enter the Bank Name You are Registered',
                    contentPadding: EdgeInsets.only(left: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Accept Cash on Delivery
                InkWell(
                  onTap: () {
                    BlocProvider.of<AccountBloc>(context).add(
                      CheckBoxAccountEvent(acceptCashOnDelivery: !state.acceptCashOnDelivery),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: state.acceptCashOnDelivery
                                  ? Colors.blue
                                  : Colors.white,
                              border: Border.all(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: state.acceptCashOnDelivery
                                  ? Icon(
                                      Icons.check,
                                      size: 14.0,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      size: 14.0,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Expanded(
                        flex: 9,
                        child: Text(
                          "Accept Cash on Delivery",
                          style: TextStyle(
                            color: colorDarkBackground,
                            letterSpacing: 1,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  elevation: 5.0,
                  onPressed: () {
                    print("Update Payment Method Button Pressed");

                    UpdatePaymentParam param = UpdatePaymentParam();
                    param.paypal = _payPalController.text;
                    param.wechat = _weChatController.text;
                    param.bankAccountName = _bankAccountNameController.text;
                    param.bankAccountNumber = _bankAccountNumberController.text;
                    param.bankName = _bankNameController.text;
                    param.cod = state.acceptCashOnDelivery;

                    CustomDialog.showLoadingDialog(context: context);
                    BlocProvider.of<AccountBloc>(context).add(
                      UpdatePaymentEvent(updatePaymentParam: param),
                    );
                  },
                  padding: const EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Theme.Colors.turqoiseNormal,
                  child: Text(
                    'Update Payment Method',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentNotification(
    GlobalResponse response,
    AccountState state,
  ) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Appointments",
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  "When you are engaging in an Appointment process",
                  style: TextStyle(
                    color: colorGreyGaijin,
                    letterSpacing: 1,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Switch(
                value: notificationAppointment,
                activeColor: Theme.Colors.turqoiseNormal,
                onChanged: (value) {
                  setState(() {
                    notificationAppointment = !notificationAppointment;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesNotification(
    GlobalResponse response,
    AccountState state,
  ) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Messages",
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  "Someone sent you a message",
                  style: TextStyle(
                    color: colorGreyGaijin,
                    letterSpacing: 1,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Switch(
                value: notificationMessages,
                activeColor: Theme.Colors.turqoiseNormal,
                onChanged: (value) {
                  setState(() {
                    notificationMessages = !notificationMessages;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLikesNotification(
    GlobalResponse response,
    AccountState state,
  ) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Likes",
                  style: TextStyle(
                    color: colorDarkBackground,
                    letterSpacing: 1,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  "Someone liked your item",
                  style: TextStyle(
                    color: colorGreyGaijin,
                    letterSpacing: 1,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Switch(
                value: notificationLikes,
                activeColor: Theme.Colors.turqoiseNormal,
                onChanged: (value) {
                  setState(() {
                    notificationLikes = !notificationLikes;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPushNotifications(GlobalResponse response, AccountState state) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Push Notifications
            Text(
              "Push Notifications",
              style: TextStyle(
                color: colorDarkBackground,
                letterSpacing: 1,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 4),
            _buildAppointmentNotification(response, state),
            _buildMessagesNotification(response, state),
            _buildLikesNotification(response, state),
          ],
        ),
      ),
    );
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

  Widget _buildButtonSignOut(GlobalResponse response, AccountState state) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                CustomDialog.showLoadingDialog(context: context);
                BlocProvider.of<AccountBloc>(context).add(
                  SignOutEvent(),
                );
              },
              child: Text(
                "Sign Out",
                style: TextStyle(
                  color: Colors.red,
                  letterSpacing: 1,
                  fontSize: 13.0,
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

  Widget _buildContent(GlobalResponse response, AccountState state) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      key: PageStorageKey(BottomPage.page_4),
      controller: _scrollController,
      slivers: <Widget>[
        _buildSliverAppBar(response, state),
        _buildWidgetHeader("Collections"),
        _buildCollectionsContent(response, state),
        _buildWidgetHeader("Profile Settings"),
        _buildPersonalInformation(response, state),
        _buildSpacingArea(color: colorSoftBlue, height: 10),
        _buildYourLocation(response, state),
        _buildPaymentMethod(response, state),
        _buildSpacingArea(color: colorSoftBlue, height: 10),
        _buildPushNotifications(response, state),
        _buildSpacingArea(color: colorSoftBlue, height: 10),
        _buildButtonSignOut(response, state),
        _buildSpacingArea(color: colorSoftBlue, height: 100),
      ],
    );
  }

  Widget _buildBody(GlobalResponse response, AccountState state) {
    return FutureBuilder(
      future: _setDefaultProfileValue(state.response),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<AccountBloc>(context).add(
                GetAccountEvent(),
              );
              return _refreshCompleter.future;
            },
            child: _buildContent(response, state),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (BuildContext context, AccountState state) async {
        if (state is AccountResponse) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }

        if (state is AccountSignOutResponse) {
          CustomDialog.hidePopupDialog(context: context);

          String status = state.response.status;
          if (status == "Success") {
            CustomDialog.showSuccessDialog(
              context: context,
              title: state.response.status,
              message: state.response.message,
            );

            goToLoginPage(context);
          } else {
            CustomDialog.showErrorDialog(
              context: context,
              title: state.response.status,
              message: state.response.message,
            );
          }
        }

        if (state is UpdateProfileResponse) {
          CustomDialog.hidePopupDialog(context: context);

          String status = state.response.status;
          if (status == "Success") {
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

          BlocProvider.of<AccountBloc>(context).add(
            GetAccountEvent(),
          );
        }

        if (state is UpdatePaymentResponse) {
          CustomDialog.hidePopupDialog(context: context);

          String status = state.response.status;
          if (status == "Success") {
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

          BlocProvider.of<AccountBloc>(context).add(
            GetAccountEvent(),
          );
        }

        if (state is AccountResponse) {
          isSubscribed = await DataSession().getSubscriptionStatus();
          isFromAddProduct = await DataSession().getAddProductStatus();
          if (isSubscribed != null && !isSubscribed && isFromAddProduct != null && isFromAddProduct) {
            becomeMemberModal(context, state.response);
          }
          DataSession().setAddProductStatus(false);
        }
        
      },
      builder: (context, state) {
        if (state is AccountLoading) {
          return IllustrationLoading();
        } else if (state is AccountResponse) {
          if (state.response.status == "Success") {
            return _buildBody(state.response, state);
          } else {
            return _showError("Error => ${state.response.message}");
          }
        } else if (state is AccountError) {
          return _showError("Error => ${state.message}");
        }
        return IllustrationLoading();
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _birthDayController.dispose();
    _shortBioController.dispose();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}
