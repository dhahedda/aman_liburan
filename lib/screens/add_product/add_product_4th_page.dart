import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:aman_liburan/app_base_configuration.dart';
import 'package:aman_liburan/blocs/add_product/add_product_bloc.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/page.dart';
import 'package:aman_liburan/screens/detail_product/product_list.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/custom_dialog.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class AddProduct4thPage extends StatefulWidget {
  final bool isEditProduct;
  final AddProductParam addProductParam;
  final EditProductParam editProductParam;

  AddProduct4thPage({
    Key key,
    @required this.isEditProduct,
    this.addProductParam,
    this.editProductParam,
  }) : super(key: key);

  @override
  _AddProduct4thPageState createState() => _AddProduct4thPageState();
}

class _AddProduct4thPageState extends State<AddProduct4thPage> {
  final TextEditingController _priceController = TextEditingController();
  AddProductParam _addProductParam;
  EditProductParam _editProductParam;
  LocationResult _pickedLocation;

  @override
  void initState() {
    super.initState();
    _addProductParam = widget.addProductParam;
    _editProductParam = widget.editProductParam;
    if (widget.isEditProduct) {
      _priceController.text = _editProductParam.product.price.toString();
      _pickedLocation = LocationResult(
          latLng: LatLng(
        _editProductParam.product.latitude,
        _editProductParam.product.longitude,
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceController.dispose();
  }

  String dateTimeToTimeString(DateTime dateTime) => dateTime.toString().split(' ')[1].substring(0, 5);

  @override
  Widget build(BuildContext context) => BlocProvider<AddProductBloc>(
      create: (context) => AddProductBloc(),
      child: BlocConsumer<AddProductBloc, AddProductState>(
        listener: (context, state) {
          if (state is AddProductLoading) {
            CustomDialog.showLoadingDialog(context: context);
          }
          if (state is AddProductSuccess) {
            CustomDialog.hidePopupDialog(context: context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AppBaseConfiguration(
                      page: BottomPage.page_2,
                    )));
            CustomDialog.showSuccessDialog(
              context: context,
              title: state.response.status,
              message: state.response.message,
            );
          }
          if (state is EditProductSuccess) {
            CustomDialog.hidePopupDialog(context: context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AppBaseConfiguration(
                      page: BottomPage.page_4,
                    )));
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductListPage()));
            CustomDialog.showSuccessDialog(
              context: context,
              title: state.response.status,
              message: state.response.message,
            );
          }
          if (state is AddProductError) {
            CustomDialog.hidePopupDialog(context: context);
            CustomDialog.showErrorDialog(
              context: context,
              title: 'Error',
              message: state.message,
            );
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductListPage()));
          }
        },
        builder: (context, state) {
          final dynamic _addProductBloc = BlocProvider.of<AddProductBloc>(context);

          Widget _buildAppBar() {
            return AppBar(
              title: Text('How much is this item?', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
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

          Widget _buildPriceInput() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      ThousandsFormatter(formatter: NumberFormat.decimalPattern("ja_JA")),
                    ],
                    decoration: InputDecoration(
                      prefixText: '¥ ',
                      hintText: 'Type item\'s price',
                      hintStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ),
              ],
            );
          }

          Widget _buildLocationInput() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Where is this item located?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () async {
                      _pickedLocation = await showLocationPicker(
                        context,
                        'AIzaSyDMfKubsjzh6i0pW2VF3egyCbTz0nfVbws',
                        automaticallyAnimateToCurrentLocation: true,
                        myLocationButtonEnabled: true,
                        layersButtonEnabled: true,
                      );
                      print("result = $_pickedLocation");
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 24.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                _pickedLocation == null
                                    ? 'Choose location'
                                    : _pickedLocation.address == null
                                        ? '${_pickedLocation.latLng.latitude.toStringAsFixed(2)}, ${_pickedLocation.latLng.longitude.toStringAsFixed(2)}'
                                        : _pickedLocation.address,
                                style: TextStyle(fontSize: 16.0, color: colorGreyGaijin),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 30.0,
                              color: colorGreyGaijin,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          Widget _buildPublishItemButton() {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: FlatButton(
                color: colorOrangeGaijin,
                onPressed: () {
                  if (widget.isEditProduct) {
                    _editProductParam.product.price = int.parse(_priceController.text.replaceAll(',', ''));
                    if (_pickedLocation != null) {
                      _editProductParam.product.latitude = _pickedLocation.latLng.latitude;
                      _editProductParam.product.longitude = _pickedLocation.latLng.longitude;
                    }
                    // print(_editProductParam);
                    _addProductBloc.add(EditProductPostEvent(editProductParam: _editProductParam));
                  } else {
                    _addProductParam.product.price = int.parse(_priceController.text.replaceAll(',', ''));
                    if (_pickedLocation != null) {
                      _addProductParam.product.latitude = _pickedLocation.latLng.latitude;
                      _addProductParam.product.longitude = _pickedLocation.latLng.longitude;
                    }
                    _addProductBloc.add(AddProductPostEvent(addProductParam: _addProductParam));
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Publish Item',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            );
          }

          Widget _buildBody() {
            return ListView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                _buildPriceInput(),
                _buildLocationInput(),
                _buildPublishItemButton(),
              ],
            );
          }

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: _buildAppBar(),
              body: _buildBody(),
            ),
          );
        },
      ));
}
