import 'package:aman_liburan/bottom_navigation_general_user.dart';
import 'package:aman_liburan/screens/dashboard/dashboard_page.dart';
import 'package:aman_liburan/screens/home/home_page.dart';
import 'package:aman_liburan/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:aman_liburan/page.dart';


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
            child: BottomNavigationGeneralUser(
              page: _page,
              onSelectPage: _selectPage,
            ),
            // child: BottomNavigationGovernment(
            //   page: _page,
            //   onSelectPage: _selectPage,
            // ),
            // child: BottomNavigationFiledOfficer(
            //   page: _page,
            //   onSelectPage: _selectPage,
            // ),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return <BottomPage, WidgetBuilder>{
      // General User
      BottomPage.page_1: (_) => HomePage(key: PageStorageKey(BottomPage.page_1)),
      BottomPage.page_2: (_) => ProfilePage(key: PageStorageKey(BottomPage.page_2)),
      // // Government
      // BottomPage.page_1: (_) => AddProduct1stPage(key: PageStorageKey(BottomPage.page_1), isEditProduct: false),
      // BottomPage.page_2: (_) => Dashboard(key: PageStorageKey(BottomPage.page_2)),
      // BottomPage.page_3: (_) => AppointmentPage(key: PageStorageKey(BottomPage.page_3)),
      // BottomPage.page_4: (_) => AccountPage(key: PageStorageKey(BottomPage.page_4)),
      // // Field Officer
      // BottomPage.page_1: (_) => CheckInFormPage(key: PageStorageKey(BottomPage.page_1)),
      // BottomPage.page_2: (_) => OfficerHomePage(key: PageStorageKey(BottomPage.page_2)),
      // BottomPage.page_3: (_) => CheckOutPage(key: PageStorageKey(BottomPage.page_3)),
    }[_page](context);
  }
}
