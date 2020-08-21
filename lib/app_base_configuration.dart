import 'package:aman_liburan/screens/add_product/add_product_1st_page.dart';
import 'package:aman_liburan/screens/check_in/check_in_form_page.dart';
import 'package:aman_liburan/screens/check_out/check_out_page.dart';
import 'package:aman_liburan/screens/home/officer_home_page.dart';
import 'package:flutter/material.dart';
import 'package:aman_liburan/page.dart';

import 'bottom_navigation_officer.dart';

class AppBaseConfiguration extends StatefulWidget {
  final BottomPage page;

  const AppBaseConfiguration({
    Key key,
    this.page,
  }) : super(key: key);

  @override
  _AppBaseConfigurationState createState() => _AppBaseConfigurationState();
}

class _AppBaseConfigurationState extends State<AppBaseConfiguration> {
  BottomPage _page = BottomPage.page_1;

  void _selectPage(BottomPage page) => setState(() => _page = page);

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    if (widget.page != null) {
      _page = widget.page;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageStorage(
            child: _buildBody(),
            bucket: bucket,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigation(
              page: _page,
              onSelectPage: _selectPage,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return <BottomPage, WidgetBuilder>{
      // BottomPage.page_1: (_) => Dashboard(key: PageStorageKey(BottomPage.page_1)),
      // BottomPage.page_2: (_) => AccountPage(key: PageStorageKey(BottomPage.page_2)),
      // BottomPage.page_3: (_) => AppointmentPage(key: PageStorageKey(BottomPage.page_3)),
      // BottomPage.page_4: (_) => AddProduct1stPage(key: PageStorageKey(BottomPage.page_4), isEditProduct: false),
      BottomPage.page_1: (_) => CheckInFormPage(key: PageStorageKey(BottomPage.page_1)),
      // BottomPage.page_2: (_) => AccountPage(key: PageStorageKey(BottomPage.page_2)),
      // BottomPage.page_2: (_) => CheckInTicketPage(key: PageStorageKey(BottomPage.page_2)),
      BottomPage.page_2: (_) => OfficerHomePage(key: PageStorageKey(BottomPage.page_2)),
      BottomPage.page_3: (_) => CheckOutPage(key: PageStorageKey(BottomPage.page_3)),
      BottomPage.page_4: (_) => AddProduct1stPage(key: PageStorageKey(BottomPage.page_4), isEditProduct: false),
    }[_page](context);
  }
}
