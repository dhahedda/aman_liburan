import 'package:aman_liburan/blocs/login/login_bloc.dart';
import 'package:aman_liburan/bottom_navigation_field_officer.dart';
import 'package:aman_liburan/bottom_navigation_general_user.dart';
import 'package:aman_liburan/bottom_navigation_government.dart';
import 'package:aman_liburan/components/data_session.dart';
import 'package:aman_liburan/screens/check_in/check_in_form_page.dart';
import 'package:aman_liburan/screens/check_out/check_out_page.dart';
import 'package:aman_liburan/screens/home/home_page.dart';
import 'package:aman_liburan/screens/home/officer_home_page.dart';
import 'package:aman_liburan/services/user_service.dart';
import 'package:aman_liburan/views/government/government_home_page.dart';
import 'package:aman_liburan/views/login_page.dart';
import 'package:aman_liburan/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:aman_liburan/page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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

  UserServices userService;

  bool _isLogin = false;
  int _userRole = 0;

  Future<void> _initLoginStatus() async {
    print('Getting login status...');
    _isLogin = await DataSession().getStatusLogin();
    _userRole = await DataSession().getUserRole();
    setState(() {});
    print('Done');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initLoginStatus();
    if (widget.page != null) {
      _page = widget.page;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // userService = Provider.of<UserServices>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        Widget bottomNavigation;
        // if (state is LoginSuccess) {
        if (_isLogin) {
          // if (state.user.role == 0) bottomNavigation = BottomNavigationGovernment(page: _page, onSelectPage: _selectPage);
          // if (state.user.role == 1) bottomNavigation = BottomNavigationFiledOfficer(page: _page, onSelectPage: _selectPage);
          // if (state.user.role == 2) bottomNavigation = BottomNavigationGeneralUser(page: _page, onSelectPage: _selectPage);
          if (_userRole == 0) bottomNavigation = BottomNavigationGovernment(page: _page, onSelectPage: _selectPage);
          if (_userRole == 1) bottomNavigation = BottomNavigationFiledOfficer(page: _page, onSelectPage: _selectPage);
          if (_userRole == 2) bottomNavigation = BottomNavigationGeneralUser(page: _page, onSelectPage: _selectPage);
          return Scaffold(
            body: Stack(
              children: <Widget>[
                PageStorage(
                  child: _buildBody(_userRole),
                  bucket: bucket,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: bottomNavigation,
                )
              ],
            ),
          );
        }
        return LoginPage();
      },
    );
  }

  Widget _buildBody(role) {
    if (role == 0) {
      // Government
      return <BottomPage, WidgetBuilder>{
        BottomPage.page_1: (_) => GovernmentHomePage(key: PageStorageKey(BottomPage.page_1)),
        BottomPage.page_2: (_) => HomePage(key: PageStorageKey(BottomPage.page_2)),
        BottomPage.page_3: (_) => HomePage(key: PageStorageKey(BottomPage.page_3)),
        BottomPage.page_4: (_) => ProfilePage(key: PageStorageKey(BottomPage.page_4)),
      }[_page](context);
    } else if (role == 1) {
      // Field Officer
      return <BottomPage, WidgetBuilder>{
        BottomPage.page_1: (_) => CheckInFormPage(key: PageStorageKey(BottomPage.page_1)),
        BottomPage.page_2: (_) => OfficerHomePage(key: PageStorageKey(BottomPage.page_2)),
        BottomPage.page_3: (_) => CheckOutPage(key: PageStorageKey(BottomPage.page_3)),
      }[_page](context);
    } else {
      // General User
      return <BottomPage, WidgetBuilder>{
        BottomPage.page_1: (_) => HomePage(key: PageStorageKey(BottomPage.page_1)),
        BottomPage.page_2: (_) => ProfilePage(key: PageStorageKey(BottomPage.page_2)),
      }[_page](context);
    }
  }
}
