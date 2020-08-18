import 'package:flutter/material.dart';
import 'package:aman_liburan/bottom_navigation.dart';
import 'package:aman_liburan/page.dart';
import 'package:aman_liburan/screens/account/account_page.dart';
import 'package:aman_liburan/screens/dashboard/dashboard_page.dart';

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
      BottomPage.page_1: (_) => Dashboard(key: PageStorageKey(BottomPage.page_1)),
      BottomPage.page_2: (_) => AccountPage(key: PageStorageKey(BottomPage.page_2)),
    }[_page](context);
  }
}
