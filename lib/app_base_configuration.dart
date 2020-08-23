import 'package:aman_liburan/blocs/login/login_bloc.dart';
import 'package:aman_liburan/bottom_navigation_field_officer.dart';
import 'package:aman_liburan/bottom_navigation_general_user.dart';
import 'package:aman_liburan/bottom_navigation_government.dart';
import 'package:aman_liburan/screens/dashboard/dashboard_page.dart';
import 'package:aman_liburan/screens/home/home_page.dart';
import 'package:aman_liburan/services/user_service.dart';
import 'package:aman_liburan/views/government/government_home_page.dart';
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

  @override
  void initState() {
    super.initState();
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
        if(state is LoginSuccess) {
          if(state.user.role == 0)
            bottomNavigation = BottomNavigationGovernment(
                page: _page,
                onSelectPage: _selectPage);
          if(state.user.role == 1)
            bottomNavigation = BottomNavigationFiledOfficer(
                page: _page,
                onSelectPage: _selectPage);
          if(state.user.role == 2)
            bottomNavigation = BottomNavigationGeneralUser(
                page: _page,
                onSelectPage: _selectPage);
          return Scaffold(
            body: Stack(
              children: <Widget>[
                PageStorage(
                  child: _buildBody(state.user.role),
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
        
      }
    );
  }

  Widget _buildBody(role) {
    if(role == 0) {
      // Government
      return <BottomPage, WidgetBuilder>{
        BottomPage.page_1: (_) => GovernmentHomePage(key: PageStorageKey(BottomPage.page_1)),
        BottomPage.page_2: (_) => ProfilePage(key: PageStorageKey(BottomPage.page_2))
      }[_page](context);
    } else if(role == 1) {
      // Field Officer
      return <BottomPage, WidgetBuilder>{
        BottomPage.page_1: (_) => HomePage(key: PageStorageKey(BottomPage.page_1)),
        BottomPage.page_2: (_) => ProfilePage(key: PageStorageKey(BottomPage.page_2))
      }[_page](context);
    } else {
      // General User
      return <BottomPage, WidgetBuilder>{
        BottomPage.page_1: (_) => HomePage(key: PageStorageKey(BottomPage.page_1)),
        BottomPage.page_2: (_) => ProfilePage(key: PageStorageKey(BottomPage.page_2))
      }[_page](context);
    }
  }
}
