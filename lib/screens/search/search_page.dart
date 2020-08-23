import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:aman_liburan/blocs/search/search_bloc.dart';
import 'package:aman_liburan/models/catalog_model.dart';
import 'package:aman_liburan/models/param/search_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/search_repository.dart';
import 'package:aman_liburan/screens/detail_product/detail_product_page.dart';
import 'package:aman_liburan/screens/search/search_filter_page.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/create_product_item.dart';
import 'package:aman_liburan/utilities/widgets/illustration_loading.dart';
import 'package:aman_liburan/utilities/widgets/spin_kit_loading.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class SearchPage extends StatefulWidget {
  final String query;
  final String category;

  SearchPage({Key key, this.category, this.query}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();

  ScrollController _scrollController;
  // ScrollController _hideButtonController = ScrollController();

  bool _floatingButtonIsVisible;
  AnimationController _animationController;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;

  List<CatalogModel> _listItem = [];

  String _sortBy = 'relevance';
  int _priceMin;
  int _priceMax;
  String _category;
  String _status;

  // List<String> _data = [];
  Future<List<CatalogModel>> _future;
  int _start = 1, _limit = 10;
  int _totalItems = -1;
  bool _allItemLoaded = false;
  // ScrollController _controller =
  //     ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  ///Mimic load data
  Future<List<CatalogModel>> loadData() async {
    try {
      final response = await SearchRepository().getSearch(
          params: SearchParam(
        start: _start,
        limit: _limit,
        query: _searchController.text != '' ? _searchController.text : null,
        category: _category,
        sortBy: _sortBy,
        priceMin: _priceMin,
        priceMax: _priceMax,
        status: _status,
      ));
      setState(() {
        print(_start);
        _totalItems = response.data.totalItems;
        List<ItemsResponse> productItems = response.data.items;
        for (var i = 0; i < productItems.length; i++) {
          _listItem.add(
            CatalogModel(
              productItems[i].id,
              productItems[i].price,
              productItems[i].name,
              productItems[i].imgUrl,
              productItems[i].isLiked,
              productItems[i].availability,
              productItems[i].location,
            ),
          );
          if (_listItem.length >= _totalItems) {
            _allItemLoaded = true;
          }
        }
      });
    } catch (e) {
      _start -= _limit;
      throw Exception(e.toString());
    }
    _start = _listItem.length + 1;
    return _listItem;

    // for (var i = _currentPage; i < _currentPage + _limit; i++) {
    //   _data.add('Data item - $i');
    // }
    // _currentPage += _limit;
    // return _data;
  }

  void freshLoadData() {
    setState(() {
      _listItem = [];
      _start = 1;
      _totalItems = -1;
      _allItemLoaded = false;
      _future = loadData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    // _hideButtonController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _category = widget.category;
    if (widget.query != null) {
      _searchController.text = widget.query;
      freshLoadData();
    } else if (widget.category == null) {
      _totalItems = 0;
    }
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _floatingButtonIsVisible = true;
    _scrollController.addListener(() {
      // For infinite scroll
      var isEnd = _scrollController.offset == _scrollController.position.maxScrollExtent;
      if (isEnd && !_allItemLoaded) {
        setState(() {
          _future = loadData();
        });
      }

      // For floating button visibility
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        // Only set when the previous state is false
        // Less widget rebuilds
        if (_floatingButtonIsVisible == true) {
          _floatingButtonIsVisible = false;
          animate();
        }
      } else {
        if (_floatingButtonIsVisible == false) {
          _floatingButtonIsVisible = true;
          animate();
        }
      }
    });
    // _hideButtonController.addListener(() {
    //   if (_hideButtonController.position.userScrollDirection == ScrollDirection.reverse) {
    //     // Only set when the previous state is false
    //     // Less widget rebuilds
    //     if (_floatingButtonIsVisible == true) {
    //       _floatingButtonIsVisible = false;
    //       animate();
    //     }
    //   } else {
    //     if (_floatingButtonIsVisible == false) {
    //       _floatingButtonIsVisible = true;
    //       animate();
    //     }
    //   }
    // });
    // _future = loadData();
    _translateButton = Tween<double>(
      begin: 0.0,
      end: 32.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.50,
          curve: _curve,
        ),
      ),
    );
  }

  animate() {
    if (!_floatingButtonIsVisible) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) {
        return SearchBloc();
        // if (widget.query != null) {
        //   return (SearchBloc()..add(SearchSubmitted(query: widget.query)));
        // }
        // if (widget.category != null) {
        //   return (SearchBloc()..add(CategoryNavigated(category: widget.category)));
        // }
        // return SearchBloc();
      },
      child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        // final dynamic _searchBloc = BlocProvider.of<SearchBloc>(context);

        Widget _buildSearchField() {
          return (widget.category != null)
              ? Text(
                  widget.category,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorPrimary),
                )
              : TextField(
                  autofocus: widget.query != null || widget.category != null ? false : true,
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: "Mau wisata ke mana?",
                    hintStyle: TextStyle(color: colorGreyGaijin),
                    isDense: true,
                    filled: true,
                    fillColor: colorSoftBlue,
                    contentPadding: EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: colorGreyGaijin,
                    ),
                  ),
                  onSubmitted: (_) async {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchResultPage()));
                    // _searchBloc.add(SearchSubmitted(query: _searchController.text));
                    freshLoadData();
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: colorGreyGaijin, fontFamily: 'OpenSans', fontSize: 14.0),
                );
        }

        List<Widget> _buildTabs() {
          return [
            Tab(icon: Text('Relevancy', style: TextStyle(color: colorGreyGaijin))),
            Tab(icon: Text('Nearby', style: TextStyle(color: colorGreyGaijin))),
            Tab(icon: Text('Price', style: TextStyle(color: colorGreyGaijin))),
          ];
        }

        Widget _buildAppBar() {
          return SliverAppBar(
            title: _buildSearchField(),
            // bottom: TabBar(
            //   tabs: _buildTabs(),
            // ),
            // expandedHeight: 100.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: colorGreyGaijin),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            floating: true,
            // actions: <Widget>[
            //   // IconButton(
            //   //   icon: Icon(Icons.notifications, color: colorGreyGaijin),
            //   //   onPressed: () {
            //   //     Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
            //   //   },
            //   // ),
            //   // IconButton(
            //   //   icon: Icon(Icons.mail, color: colorGreyGaijin),
            //   //   onPressed: () {
            //   //     Navigator.push(context, MaterialPageRoute(builder: (context) => ChatLobbyPage()));
            //   //   },
            //   // ),
            // ],
          );
        }

        Widget _buildItemGrid() {
          // if (state is SearchResponse) {
          // List<ItemsResponse> productItems = state.response.data.items;
          // for (var i = 0; i < productItems.length; i++) {
          //   _listItem.add(
          //     CatalogModel(
          //       productItems[i].id,
          //       productItems[i].price,
          //       productItems[i].name,
          //       productItems[i].imgUrl,
          //       productItems[i].isLiked,
          //       productItems[i].availability,
          //     ),
          //   );
          // }
          //   List<CatalogModel> listItem = [];
          //   List<ItemsResponse> productItems = state.response.data.items;
          //   for (var i = 0; i < state.response.data.items.length; i++) {
          //     listItem.add(
          //       CatalogModel(
          //         productItems[i].id,
          //         productItems[i].price,
          //         productItems[i].name,
          //         productItems[i].imgUrl,
          //         productItems[i].isLiked,
          //         productItems[i].availability,
          //         productItems[i].location,
          //       ),
          //     );
          //   }
          //   return SliverStaggeredGrid.countBuilder(
          //       crossAxisCount: 4,
          //       mainAxisSpacing: 4.0,
          //       crossAxisSpacing: 4.0,
          //       itemBuilder: (context, index) => CreateProductItem(
          //             catalogModel: listItem[index],
          //             onTapDetail: () {
          //               print("Detail Clicked!");
          //               return Navigator.push(
          //                  context,
          //                  MaterialPageRoute(
          //                    builder: (context) => DetailProductPage(
          //                      productId: listItem[index].id,
          //                      androidFusedLocation: true,
          //                    ),
          //                  ),
          //                );
          //              },
          //              onTapCircle: () {
          //                print("Wishlist Clicked!");
          //              },
          //            ),
          //        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
          //        itemCount: listItem.length);
          //  }

          // if (_listItem.isEmpty) {
          //   return SliverList(
          //     delegate: SliverChildListDelegate([
          //       SizedBox(height: SizeConfig.getHeight(context) * .4),
          //       Center(child: Text('Item not found')),
          //     ]),
          //   );
          // }
          if (_totalItems == -1) {
            return SliverList(
              delegate: SliverChildListDelegate([IllustrationLoading()]),
            );
          }
          return FutureBuilder(
              future: _future,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<CatalogModel> loaded = snapshot.data;
                  return SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      itemBuilder: (context, index) => index == loaded.length
                          ? index >= _totalItems ? Container() : SizedBox(width: SizeConfig.getWidth(context), child: SpinKitLoading())
                          : CreateProductItem(
                              catalogModel: loaded[index],
                              onTapDetail: () {
                                FocusScope.of(context).unfocus();
                                print("Detail Clicked!");

                                return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailProductPage(
                                      productId: loaded[index].id,
                                      androidFusedLocation: true,
                                    ),
                                  ),
                                );
                              },
                              onTapCircle: () {
                                print("Wishlist Clicked!");
                              },
                            ),
                      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                      itemCount: loaded.length + 1);
                }
                return SliverList(delegate: SliverChildListDelegate([Container()]));
                // return SliverList(delegate: SliverChildListDelegate([LinearProgressIndicator()]));
              });
          // }
          // if (state is SearchLoading) {
          //   return SliverList(
          //     delegate: SliverChildListDelegate([IllustrationLoading()]),
          //   );
          // }
          // return SliverList(
          //   delegate: SliverChildListDelegate([Text('')]),
          // );
        }

        // Widget _sortListTile({@required String sortBy, bool isTopMost}) {
        //   bool isSelected = false;
        //   if (_sortBy == sortBy) isSelected = true;
        //   if (isTopMost == null) isTopMost = false;
        //   return Column(
        //     children: <Widget>[
        //       isTopMost ? Divider(height: 1.0) : Container(),
        //       InkWell(
        //         onTap: () {
        //           setState(() {
        //             _sortBy = sortBy;
        //           });
        //           freshLoadData();
        //           // _searchBloc.add(SearchSortFilterEvent(
        //           //   query: _searchController.text != '' ? _searchController.text : null,
        //           //   category: widget.category,
        //           //   sortBy: _sortBy,
        //           // ));
        //           Navigator.pop(context);
        //         },
        //         child: Container(
        //           padding: EdgeInsets.symmetric(horizontal: 32.0),
        //           height: 50.0,
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: <Widget>[
        //               Text(sortBy == 'highestprice'
        //                   ? 'Highest Price'
        //                   : sortBy == 'lowestprice' ? 'Lowest Price' : '${sortBy.substring(0, 1)[0].toUpperCase()}${sortBy.substring(1)}'),
        //               isSelected ? Icon(Icons.check, color: Colors.green) : Container(),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   );
        // }

        // Widget _buildSortBottomSheet() {
        //   return FractionallySizedBox(
        //       heightFactor: 0.42,
        //       child: Column(
        //         children: <Widget>[
        //           Padding(
        //             padding: EdgeInsets.only(top: 8.0),
        //             child: Container(
        //               height: 5.0,
        //               width: 48.0,
        //               decoration: BoxDecoration(
        //                 color: Color(0xFFCCCCCC),
        //                 borderRadius: BorderRadius.circular(50.0),
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        //             child: Align(
        //               alignment: Alignment.centerLeft,
        //               child: Text('Sort', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        //             ),
        //           ),
        //           _sortListTile(sortBy: 'relevance', isTopMost: true),
        //           _sortListTile(sortBy: 'newest'),
        //           _sortListTile(sortBy: 'oldest'),
        //           _sortListTile(sortBy: 'highestprice'),
        //           _sortListTile(sortBy: 'lowestprice'),
        //         ],
        //       ));
        // }

        // Widget _buildFilterBottomSheet() {
        //   double _starValue = 10;
        //   double _endValue = 80;
        //   return FractionallySizedBox(
        //       heightFactor: 0.42,
        //       child: Column(
        //         children: <Widget>[
        //           Padding(
        //             padding: EdgeInsets.only(top: 8.0),
        //             child: Container(
        //               height: 5.0,
        //               width: 48.0,
        //               decoration: BoxDecoration(
        //                 color: Color(0xFFCCCCCC),
        //                 borderRadius: BorderRadius.circular(50.0),
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        //             child: Align(
        //               alignment: Alignment.centerLeft,
        //               child: Text('Filter', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        //             ),
        //           ),
        //           RangeSlider(
        //             values: RangeValues(_starValue, _endValue),
        //             min: 0.0,
        //             max: 100.0,
        //             onChanged: (values) {
        //               setState(() {
        //                 _starValue = values.start.roundToDouble();
        //                 _endValue = values.end.roundToDouble();
        //               });
        //             },
        //           ),
        //         ],
        //       ));
        // }

        Widget _buildSortFilterButton() {
          return Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 2.0,
              0.0,
            ),
            child: FloatingActionButton.extended(
              heroTag: 'FilterButton',
              onPressed: () async {
                FocusScope.of(context).unfocus();
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfiniteScroll()));
                SearchParam searchParam = await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchFilterPage(
                          priceMin: _priceMin,
                          priceMax: _priceMax,
                          category: _category,
                          status: _status,
                        )));
                if (searchParam != null) {
                  setState(() {
                    _priceMin = searchParam.priceMin;
                    _priceMax = searchParam.priceMax;
                    _category = searchParam.category;
                    _status = searchParam.status;
                  });
                  freshLoadData();
                  // _searchBloc.add(SearchSortFilterEvent(
                  //   query: _searchController.text != '' ? _searchController.text : null,
                  //   sortBy: _sortBy,
                  //   category: _category,
                  //   priceMin: _priceMin,
                  //   priceMax: _priceMax,
                  //   status: _status,
                  // ));
                }
              },
              label: Text('Filter', style: TextStyle(color: Theme.Colors.turqoiseNormal)),
              icon: Icon(EvaIcons.funnel, color: Theme.Colors.turqoiseNormal),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
            ),
          );
        }

        Widget _buildBody() {
          return CustomScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              _buildAppBar(),
              _buildItemGrid(),
            ],
          );
        }

        return DefaultTabController(
          length: _buildTabs().length,
          child: Scaffold(
            body: _buildBody(),
            // floatingActionButton: state is SearchResponse ? _buildSortFilterButton() : Container(),
            floatingActionButton: _buildSortFilterButton(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
        );
      }),
    );
  }
}
