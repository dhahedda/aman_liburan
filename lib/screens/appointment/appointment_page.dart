import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aman_liburan/blocs/appointment_buyer/appointment_buyer_bloc.dart';
import 'package:aman_liburan/blocs/appointment_seller/appointment_seller_bloc.dart';
import 'package:aman_liburan/blocs/chat/chat_bloc.dart';
import 'package:aman_liburan/screens/appointment/appointment_seller_page.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';

import 'appointment_buyer_page.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppointmentSellerBloc>(
          create: (BuildContext context) =>
              AppointmentSellerBloc()..add(GetSellerAppointmentEvent()),
        ),
        BlocProvider<AppointmentBuyerBloc>(
          create: (BuildContext context) =>
              AppointmentBuyerBloc()..add(GetBuyerAppointmentEvent()),
        ),
        BlocProvider<ChatBloc>(
          create: (BuildContext context) => ChatBloc(),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Positioned(
                          //   left: 0,
                          //   top: 0,
                          //   bottom: 0,
                          //   child: IconButton(
                          //     icon: Icon(Icons.arrow_back, color: colorPrimary),
                          //     onPressed: () {
                          //       print("Back clicked");
                          //       Navigator.of(context).pop();
                          //     },
                          //   ),
                          // ),
                          Positioned(
                            left: 0,
                            top: 5,
                            right: 0,
                            bottom: 0,
                            child: Text(
                              "Appointments",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colorPrimary,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      indicatorColor: colorPrimary,
                      // indicatorSize: TabBarIndicatorSize.label,
                      labelColor: colorBlueGaijin,
                      unselectedLabelColor: colorBlueGaijin80,
                      // indicator: UnderlineTabIndicator(
                      //   borderSide: BorderSide(color: colorBlueGaijin, width: 2),
                      //   insets: EdgeInsets.symmetric(horizontal: 80),
                      // ),
                      tabs: [
                        Tab(
                          child: Text(
                            "Seller",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Buyer",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              AppointmentSellerPage(),
              AppointmentBuyerPage(),
            ],
          ),
        ),
      ),
    );
  }
}
