import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:aman_liburan/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aman_liburan/screens/dashboard/dashboard_page_category_grid_item.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/screens/search/search_page.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/blocs/dashboard/dashboard_bloc.dart';
import 'package:aman_liburan/utilities/widgets/custom_sliver_page_header.dart';
import 'package:aman_liburan/utilities/widgets/illustration_loading.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<DashboardBloc>(create: (context) => DashboardBloc()..add(GetApiDashboardEvent()), child: DashboardScreen());
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  Completer<void> _refreshCompleter;
  ScrollController _scrollController;
  TabController _tabController;
  double heightCategoryMenu;
  bool lastStatus = true;
  int filterSelected;

  bool get isShrink {
    return _scrollController.hasClients && _scrollController.offset > (200 - kToolbarHeight);
  }

  void _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    filterSelected = 0;
    heightCategoryMenu = 100;
    _refreshCompleter = Completer<void>();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _refreshCompleter.complete();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  List<T> mapingItemWidgets<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Future<String> getAdministrativeArea(double latitude, double longitude) async {
    List<Placemark> placemarks = [];
    try {
      placemarks = await Geolocator().placemarkFromCoordinates(latitude, longitude);
    } catch (e) {
      // Handle error location not found
      print("placemarks_error =>${e.toString()}");
      placemarks.add(Placemark(name: 'unknown_location'));
    }
    String administrativeArea = "Unknown Location";

    if (placemarks[0].name != "unknown_location") {
      administrativeArea = placemarks[0].administrativeArea;
    }

    return administrativeArea;
  }

  Future<double> getDistance(endLatitude, endLongitude) async {
    Position lastPosition = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    if (lastPosition == null) {
      lastPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }
    double startLatitude = lastPosition.latitude;
    double startLongitude = lastPosition.longitude;

    double distanceInMeters = await Geolocator().distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );

    double distanceInKm = (distanceInMeters / 1000);
    return distanceInKm;
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

  Widget _buildAppBarHeaderText(BuildContext context, DashboardState state) {
    return AnimatedOpacity(
      opacity: isShrink ? 0.8 : 1.0,
      duration: Duration(milliseconds: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sudah\nMenemukan",
            style: TextStyle(
              color: colorDarkBackground,
              letterSpacing: 1,
              fontSize: 28.0,
              fontWeight: FontWeight.w800,
              fontFamily: "Poppins",
            ),
            maxLines: 2,
          ),
          Text(
            "Wisata Aman",
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1,
              fontSize: 28.0,
              fontWeight: FontWeight.w900,
              fontFamily: "Poppins",
            ),
            maxLines: 2,
          ),
          Text(
            "Untukmu?",
            style: TextStyle(
              color: colorDarkBackground,
              letterSpacing: 1,
              fontSize: 28.0,
              fontWeight: FontWeight.w800,
              fontFamily: "Poppins",
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarSearchInput(BuildContext context, DashboardState state) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SearchPage(),
          ),
        );
      },
      // onSubmitted: (_) {
      //   String searchedText = _searchController.text;
      //   _searchController.text = '';
      //   Navigator.of(context).push(
      //     PageRouteBuilder(
      //       pageBuilder: (context, animation1, animation2) =>
      //           SearchPage(query: searchedText),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: "Mau wisata ke mana?",
          hintStyle: TextStyle(color: colorGreyGaijin),
          isDense: true,
          filled: true,
          fillColor: colorSoftBlue,
          contentPadding: EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: colorGreyGaijin,
          ),
        ),
        style: TextStyle(color: colorGreyGaijin, fontFamily: 'OpenSans', fontSize: 14.0),
      ),
    );
  }

  Widget _buildSvg(BuildContext context, DashboardState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: SvgPicture.asset(
        "assets/svg/walking_person.svg",
        height: 200.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAppBarHeader(BuildContext context, DashboardState state) {
    return SliverToBoxAdapter(
      child: Container(
        color: Theme.Colors.turqoiseNormal,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 2, child: _buildAppBarHeaderText(context, state)),
              Expanded(flex: 1, child: _buildSvg(context, state)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterProductChips(BuildContext context, DashboardState state) {
    List<String> filter = [
      "Semua Wisata",
      "Wisata Air",
      "Wisata Alam",
      "Wisata Gunung",
    ];

    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filter.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: ChoiceChip(
              label: Text(
                filter[index],
                style: TextStyle(
                  color: (filterSelected == index) ? Colors.white : colorGreyGaijin,
                  letterSpacing: 1,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
                maxLines: 2,
              ),
              selected: filterSelected == index,
              selectedColor: Theme.Colors.turqoiseNormal,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                side: BorderSide(
                  width: 1,
                  color: colorSoftBlue,
                ),
              ),
              onSelected: (bool selected) {
                setState(() {
                  filterSelected = selected ? index : filterSelected;
                });
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => SearchPage(query: filter[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBarContent(BuildContext context, DashboardState state) {
    return SliverPersistentHeader(
      delegate: CustomSliverPageHeader(
        minHeight: 120,
        maxHeight: 120,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              isShrink
                  ? Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: _buildAppBarSearchInput(context, state),
                          ),
                          Expanded(
                            flex: 1,
                            child: _buildSvg(context, state),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      child: _buildAppBarSearchInput(context, state),
                    ),
              SizedBox(height: 4.0),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: _buildFilterProductChips(context, state),
              ),
            ],
          ),
        ),
      ),
      pinned: true,
    );
  }

  Widget _buildTabBarPresistentContent(
    BuildContext context,
    DashboardState state,
  ) {
    List<CategoriesResponse> listCategories = (state as OnDashboardResponse).response.data.categories;

    return Container(
      height: SizeConfig.getHeight(context),
      child: TabBarView(
        controller: _tabController,
        physics: ClampingScrollPhysics(),
        children: listCategories.map((CategoriesResponse category) {
          return DashboardPageCategoryGridItem(categoryId: category.name);
        }).toList(),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DashboardState state) {
    List<CategoriesResponse> listCategories = (state as OnDashboardResponse).response.data.categories;

    return SafeArea(
      child: DefaultTabController(
        length: listCategories.length,
        child: NestedScrollView(
          key: PageStorageKey(BottomPage.page_1),
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _buildAppBarHeader(context, state),
              _buildAppBarContent(context, state),
            ];
          },
          body: _buildTabBarPresistentContent(context, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, DashboardState state) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<DashboardBloc>(context).add(
          GetApiDashboardEvent(),
        );
        return _refreshCompleter.future;
      },
      child: _buildContent(context, state),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (BuildContext context, DashboardState state) {
        if (state is OnDashboardResponse) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }
      },
      builder: (BuildContext context, DashboardState state) {
        if (state is OnDashboardLoading) {
          return IllustrationLoading();
        } else if (state is OnDashboardResponse) {
          if (state.response.status == "Success") {
            return _buildBody(context, state);
          } else {
            return _buildError(context, state.response.message);
          }
        } else if (state is OnDashboardError) {
          return _buildError(context, state.message);
        }
        return IllustrationLoading();
      },
    );
  }
}
