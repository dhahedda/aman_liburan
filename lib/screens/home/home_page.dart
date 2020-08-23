import 'dart:async';

import 'package:aman_liburan/blocs/home/home_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:aman_liburan/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/screens/search/search_page.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/custom_sliver_page_header.dart';
import 'package:aman_liburan/utilities/widgets/illustration_loading.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<HomeBloc>(create: (context) => HomeBloc()..add(GetApiHomeEvent()), child: HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  Completer<void> _refreshCompleter;
  ScrollController _scrollController;
  // TabController _tabController;
  double heightCategoryMenu;
  bool lastStatus = true;
  int filterSelected;

  bool get isShrink {
    return _scrollController.hasClients && _scrollController.offset > (200 - kToolbarHeight);
  }

  List<String> _filter = [
    "Semua Wisata",
    "Wisata Air",
    "Wisata Alam",
    "Wisata Gunung",
  ];

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
    return Scaffold(
      body: Container(
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
      ),
    );
  }

  Widget _buildAppBarHeaderText(BuildContext context) {
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

  Widget _buildAppBarSearchInput(BuildContext context) {
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

  Widget _buildSvg(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: SvgPicture.asset(
        "assets/svg/walking_person.svg",
        height: 200.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAppBarHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Theme.Colors.turqoiseNormal,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 2, child: _buildAppBarHeaderText(context)),
              Expanded(flex: 1, child: _buildSvg(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterProductChips(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filter.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: ChoiceChip(
              label: Text(
                _filter[index],
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
                // Navigator.of(context).push(
                //   PageRouteBuilder(
                //     pageBuilder: (context, animation1, animation2) => SearchPage(query: _filter[index]),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBarContent(BuildContext context) {
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
                            child: _buildAppBarSearchInput(context),
                          ),
                          Expanded(
                            flex: 1,
                            child: _buildSvg(context),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      child: _buildAppBarSearchInput(context),
                    ),
              SizedBox(height: 4.0),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: _buildFilterProductChips(context),
              ),
            ],
          ),
        ),
      ),
      pinned: true,
    );
  }

  // Widget _buildTabBarPresistentContent(BuildContext context) {
  //   // List<CategoriesResponse> listCategories = (state as OnHomeResponse).response.data.categories;

  //   return Container(
  //     height: SizeConfig.getHeight(context),
  //     child: TabBarView(
  //       controller: _tabController,
  //       physics: ClampingScrollPhysics(),
  //       children: _filter.map((String filter) {
  //         return DashboardPageCategoryGridItem(categoryId: filter);
  //       }).toList(),
  //     ),
  //   );
  // }

  Widget _buildContent(BuildContext context) {
    // List<CategoriesResponse> listCategories = (state as OnHomeResponse).response.data.categories;

    return SafeArea(
      child: DefaultTabController(
        length: _filter.length,
        child: NestedScrollView(
          key: PageStorageKey(BottomPage.page_1),
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _buildAppBarHeader(context),
              _buildAppBarContent(context),
            ];
          },
          // body: _buildTabBarPresistentContent(context),
          body: Container(),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Theme.Colors.turqoiseNormal,
      child: SafeArea(
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<HomeBloc>(context).add(
                GetApiHomeEvent(),
              );
              return _refreshCompleter.future;
            },
            // child: Container(),
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state is OnHomeResponse) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }
      },
      builder: (BuildContext context, HomeState state) {
        if (state is OnHomeLoading) {
          return IllustrationLoading();
        } else if (state is OnHomeResponse) {
          if (state.response != null) {
            return _buildBody(context);
          } else {
            return _buildError(context, state.response.message);
          }
        } else if (state is OnHomeError) {
          return _buildError(context, state.message);
        }
        return IllustrationLoading();
      },
    );
  }
}
