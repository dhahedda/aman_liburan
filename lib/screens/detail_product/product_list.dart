import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:aman_liburan/blocs/product_list/product_list_bloc.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/screens/add_product/add_product_1st_page.dart';
import 'package:aman_liburan/screens/detail_product/detail_product_page.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/cached_image.dart';
import 'package:aman_liburan/utilities/widgets/custom_dialog.dart';
import 'package:aman_liburan/utilities/widgets/illustration_loading.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

// doneTODO edit productt page perlu dibikin
// doneTODO product list:
// details  https://go.2gaijin.com/products/5e847999b0a17c4efe95191c
// manage pricing  https://go.2gaijin.com/edit_pricing
// edit  https://go.2gaijin.com/edit_product
// mark as sold  https://go.2gaijin.com/mark_as_sold
class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final _searchController = TextEditingController();
  final _priceController = TextEditingController();
  // Uncomment fos CheckBox functionality
  // bool _isCheckedGlobal = false;
  // List<bool> _isCheckedList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  String dateTimeToTimeString(DateTime dateTime) => dateTime.toString().split(' ')[1].substring(0, 5);

  @override
  Widget build(BuildContext context) => BlocProvider<ProductListBloc>(
      create: (context) => ProductListBloc()..add(ProductListInitiateEvent()),
      child: BlocConsumer<ProductListBloc, ProductListState>(listener: (context, state) {
        final dynamic _productListBloc = BlocProvider.of<ProductListBloc>(context);
        if (state is ProductListResponse) {
          // CustomDialog.hidePopupDialog(context: context);
          // Uncomment for ChackBox functionality
          // setState(() {
          //   for (int i = 0; i < state.productList.length; i++) {
          //     _isCheckedList.add(false);
          //   }
          // });
        }
        if (state is ProductListApiLoading) {
          CustomDialog.showLoadingDialog(context: context);
        }
        if (state is ProductListPriceUpdated) {
          CustomDialog.hidePopupDialog(context: context);
          CustomDialog.showSuccessDialog(
            context: context,
            title: state.response.status,
            message: state.response.message,
          );
          _productListBloc.add(ProductListInitiateEvent());
        }
        if (state is ProductListEditNavigated) {
          CustomDialog.hidePopupDialog(context: context);
          Navigator.pop(context);
          ItemResponse item = state.response.data.item;
          DetailItemResponse detail = state.response.data.details;
          _productListBloc.add(ProductListInitiateEvent());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduct1stPage(
                isEditProduct: true,
                editProductParam: EditProductParam(
                  product: Product(
                    id: item.id,
                    name: item.name,
                    price: item.price,
                    description: item.description,
                    categoryIds: item.categoryIds,
                    latitude: item.latitude,
                    longitude: item.longitude,
                  ),
                  productDetail: ProductDetail(
                    brand: detail.brand,
                    condition: detail.condition,
                    yearsOwned: detail.yearsOwned,
                    modelName: detail.modelName,
                  ),
                ),
              ),
            ),
          );
        }
        if (state is ProductListError) {
          CustomDialog.hidePopupDialog(context: context);
          CustomDialog.showErrorDialog(
            context: context,
            title: 'Error',
            message: state.message,
          );
          _productListBloc.add(ProductListInitiateEvent());
        }
      }, builder: (context, state) {
        final dynamic _productListBloc = BlocProvider.of<ProductListBloc>(context);

        Widget _buildManagePricingBottomSheet(ItemsResponse itemsResponse) {
          return FractionallySizedBox(
            heightFactor: 0.75,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 5.0,
                    width: 48.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFCCCCCC),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Manage Pricing', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        ThousandsFormatter(formatter: NumberFormat.decimalPattern("ja_JA")),
                      ],
                      decoration: InputDecoration(
                        prefixText: '¥ ',
                        hintText: 'Type new price',
                        hintStyle: TextStyle(color: colorGreyGaijin),
                        isDense: true,
                        filled: true,
                        fillColor: colorSoftBlue,
                        contentPadding: EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
                        ),
                      ),
                      onChanged: (_) {
                        setState(() {});
                      },
                      onSubmitted: (_) {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchResultPage()));
                        // _searchBloc.add(SearchSubmitted(query: _searchController.text));
                      },
                      style: TextStyle(color: colorGreyGaijin, fontFamily: 'OpenSans', fontSize: 32.0),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      child: RaisedButton(
                        elevation: 10.0,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          _productListBloc.add(ProductListUpdatePriceEvent(productId: itemsResponse.id, productNewPrice: int.parse(_priceController.text.replaceAll(',', ''))));
                        },
                        padding: const EdgeInsets.all(12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: colorSecondary,
                        child: Text(
                          'Update Price',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                            // fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 48.0),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: colorSecondary.withOpacity(0.75),
                            blurRadius: 7.5,
                            offset: Offset(0, 2.0),
                          ),
                        ],
                      ),
                      child: ButtonTheme(
                        minWidth: double.infinity,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          padding: const EdgeInsets.all(12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            'Close',
                            style: TextStyle(
                              color: colorSecondary,
                              letterSpacing: 1,
                              // fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 24.0),
                //   child: FractionallySizedBox(
                //     widthFactor: 0.9,
                //     child: ButtonTheme(
                //       minWidth: double.infinity,
                //       child: FlatButton(
                //         onPressed: () {
                //           Navigator.pop(context);
                //           Navigator.pop(context);
                //           CustomDialog.showLoadingDialog(context: context);
                //         },
                //         padding: const EdgeInsets.all(12.0),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(50.0),
                //         ),
                //         color: colorSecondary,
                //         child: Text(
                //           'Update Price',
                //           style: TextStyle(
                //             color: Colors.white,
                //             letterSpacing: 1,
                //             fontSize: 24.0,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: 'Poppins',
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 32.0),
                //   child: FractionallySizedBox(
                //     widthFactor: 0.9,
                //     child: ButtonTheme(
                //       minWidth: double.infinity,
                //       child: OutlineButton(
                //         onPressed: () {
                //           Navigator.pop(context);
                //           Navigator.pop(context);
                //         },
                //         padding: const EdgeInsets.all(12.0),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(50.0),
                //         ),
                //         borderSide: BorderSide(color: colorSecondary),
                //         color: Colors.white,
                //         child: Text(
                //           'Close',
                //           style: TextStyle(
                //             color: colorSecondary,
                //             letterSpacing: 1,
                //             fontSize: 24.0,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: 'Poppins',
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        }

        Widget _buildManagePricingTile(ItemsResponse itemsResponse) {
          return InkWell(
            onTap: () {
              _priceController.text = NumberFormat('#,###.##', 'ja_JA').format(itemsResponse.price);
              showModalBottomSheet(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                ),
                isScrollControlled: true,
                context: context,
                builder: (context) => _buildManagePricingBottomSheet(itemsResponse),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.attach_money, color: Colors.black87),
                  ),
                  Text(
                    'Manage pricing',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }

        Widget _buildEditTile(ItemsResponse itemsResponse) {
          return InkWell(
            onTap: () {
              _productListBloc.add(ProductListEditEvent(productId: itemsResponse.id));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.edit, color: Colors.black87),
                  ),
                  Text(
                    'Edit',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }

        Widget _buildMarkAsSoldTile(ItemsResponse itemsResponse) {
          return InkWell(
            onTap: () {
              _productListBloc.add(ProductListMarkAsSoldEvent(productId: itemsResponse.id));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.money_off, color: colorPink),
                  ),
                  Text(
                    'Mark as sold',
                    style: TextStyle(fontWeight: FontWeight.bold, color: colorPink),
                  ),
                ],
              ),
            ),
          );
        }

        Widget _buildMarkAsAvailableTile(ItemsResponse itemsResponse) {
          return InkWell(
            onTap: () {
              _productListBloc.add(ProductListMarkAsSoldEvent(productId: itemsResponse.id));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(EvaIcons.shoppingBag, color: colorTosca),
                  ),
                  Text(
                    'Mark as available',
                    style: TextStyle(fontWeight: FontWeight.bold, color: colorTosca),
                  ),
                ],
              ),
            ),
          );
        }

        Widget _buildOptionBottomSheet(ItemsResponse itemsResponse) {
          return FractionallySizedBox(
            heightFactor: 0.26,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 5.0,
                    width: 48.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFCCCCCC),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(itemsResponse.name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                ),
                _buildManagePricingTile(itemsResponse),
                _buildEditTile(itemsResponse),
                itemsResponse.availability == 'available' ? _buildMarkAsSoldTile(itemsResponse) : _buildMarkAsAvailableTile(itemsResponse),
              ],
            ),
          );
        }

        Widget _buildAppBar() {
          return AppBar(
            title: Text('Product List', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 4.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Try Shelf, Fan, or Camera",
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
                  onChanged: (_) {
                    setState(() {});
                  },
                  onSubmitted: (_) {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchResultPage()));
                    // _searchBloc.add(SearchSubmitted(query: _searchController.text));
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: colorGreyGaijin, fontFamily: 'OpenSans', fontSize: 14.0),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: colorGreyGaijin),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        }

        // Widget _buildChooseAll() {
        //   if (state is ProductListResponse) {
        //     return CheckboxListTile(
        //       value: _isCheckedGlobal,
        //       onChanged: (bool value) {
        //         setState(() {
        //           _isCheckedGlobal = !_isCheckedGlobal;
        //           for (int i = 0; i < state.productList.length; i++) {
        //             if (_searchController.text == '' || state.productList[i].name.toLowerCase().contains(_searchController.text.toLowerCase())) {
        //               _isCheckedList[i] = _isCheckedGlobal;
        //             }
        //           }
        //         });
        //       },
        //       activeColor: Colors.deepOrange,
        //       controlAffinity: ListTileControlAffinity.leading,
        //       title: Text(
        //         'Choose all items',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //     );
        //   }
        //   return Container();
        // }

        Widget _buildProductTile(ItemsResponse itemsResponse, int index) {
          return ListTile(
            title: Row(
              children: <Widget>[
                CachedImage(
                  width: 75.0,
                  height: 75.0,
                  imageUrl: itemsResponse.imgUrl,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          itemsResponse.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(height: 1.4, color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 13.0),
                        ),
                        Text(
                          // TODO implement thousand separator on all price
                          // '¥${itemsResponse.price}',
                          '¥${NumberFormat('#,###.##', 'ja_JA').format(itemsResponse.price)}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(height: 1.4, color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailProductPage(
                    productId: itemsResponse.id,
                    androidFusedLocation: true,
                  ),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                  ),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => _buildOptionBottomSheet(itemsResponse),
                );
              },
            ),
          );
          // CheckBox template for future use
          // return CheckboxListTile(
          //   title: Row(
          //     children: <Widget>[
          //       CachedImage(
          //         width: 75.0,
          //         height: 75.0,
          //         imageUrl: itemsResponse.imgUrl,
          //       ),
          //       Expanded(
          //         child: Padding(
          //           padding: const EdgeInsets.only(left: 8.0),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               Text(
          //                 itemsResponse.name,
          //                 overflow: TextOverflow.ellipsis,
          //                 maxLines: 2,
          //                 style: TextStyle(height: 1.4, color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 13.0),
          //               ),
          //               Text(
          //                 '¥${itemsResponse.price}',
          //                 overflow: TextOverflow.ellipsis,
          //                 style: TextStyle(height: 1.4, color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 18.0),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          //   value: _isCheckedList[index],
          //   controlAffinity: ListTileControlAffinity.leading,
          //   activeColor: Colors.deepOrange,
          //   onChanged: (bool value) {
          //     setState(() {
          //       _isCheckedList[index] = !_isCheckedList[index];
          //       if (_isCheckedList[index] == false) {
          //         _isCheckedGlobal = false;
          //       }
          //     });
          //   },
          //   secondary: IconButton(
          //     icon: Icon(Icons.more_vert),
          //     onPressed: () {
          //       showModalBottomSheet(
          //         backgroundColor: Colors.white,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
          //         ),
          //         isScrollControlled: true,
          //         context: context,
          //         builder: (context) => _buildBottomSheet(),
          //       );
          //     },
          //   ),
          // );
        }

        Widget _buildProductList() {
          if (state is ProductListResponse) {
            return Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: state.productList.length,
                itemBuilder: (context, index) {
                  if (_searchController.text == '' || state.productList[index].name.toLowerCase().contains(_searchController.text.toLowerCase())) {
                    return _buildProductTile(state.productList[index], index);
                  } else {
                    return Container();
                  }
                },
              ),
            );
          }
          return Container();
        }

        Widget _buildBody() {
          if (state is ProductListResponse) {
            return Column(
              children: <Widget>[
                // _buildChooseAll(),
                _buildProductList(),
              ],
            );
          }
          return IllustrationLoading();
        }

        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        );
      }));
}
