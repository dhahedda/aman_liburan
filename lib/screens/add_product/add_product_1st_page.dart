import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aman_liburan/app_base_configuration.dart';
import 'package:aman_liburan/components/data_session.dart';
import 'package:aman_liburan/page.dart';
import 'package:aman_liburan/blocs/add_product/add_product_bloc.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/screens/add_product/add_product_2nd_page.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/spin_kit_loading.dart';

// doneTODO check subscription status. if not subscribed, direct to subscription payment page
// pas edit cek juga
class AddProduct1stPage extends StatefulWidget {
  final bool isEditProduct;
  final ItemResponse itemResponse;
  final EditProductParam editProductParam;

  const AddProduct1stPage({
    Key key,
    @required this.isEditProduct,
    this.itemResponse,
    this.editProductParam,
  }) : super(key: key);
  @override
  _AddProduct1stPageState createState() => _AddProduct1stPageState();
}

class _AddProduct1stPageState extends State<AddProduct1stPage> {
  String dateTimeToTimeString(DateTime dateTime) => dateTime.toString().split(' ')[1].substring(0, 5);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddProductBloc>(
      create: (context) => AddProductBloc()..add(InitEvent()),
      child: BlocBuilder<AddProductBloc, AddProductState>(
        builder: (context, state) {
          Widget _buildAppBar() {
            return AppBar(
              title: Text(widget.isEditProduct ? 'Edit Product' : 'What do you want to sell today?', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
              leading: widget.isEditProduct
                  ? IconButton(
                      icon: Icon(Icons.arrow_back, color: colorGreyGaijin),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  : null,
              backgroundColor: Colors.white,
              centerTitle: true,
              automaticallyImplyLeading: false,
            );
          }

          Widget _buildCategoryButton(String category) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image(
                  width: MediaQuery.of(context).size.width * 0.45,
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/add_product/$category.png'),
                ),
                Text(
                    category.contains('_')
                        ? '${category.split('_')[0][0].toUpperCase()}${category.split('_')[0].substring(1)} ${category.split('_')[1][0].toUpperCase()}${category.split('_')[1].substring(1)}'
                        : '${category[0].toUpperCase()}${category.substring(1)}',
                    style: TextStyle(color: Colors.white, fontSize: 16.0)),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        if (state is AddProductFetched) {
                          state.response.data.categories.forEach((value) {
                            if (value.name ==
                                (category.contains('_')
                                    ? '${category.split('_')[0][0].toUpperCase()}${category.split('_')[0].substring(1)} ${category.split('_')[1][0].toUpperCase()}${category.split('_')[1].substring(1)}'
                                    : '${category[0].toUpperCase()}${category.substring(1)}')) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddProduct2ndPage(
                                            isEditProduct: widget.isEditProduct,
                                            listCategoriesResponse: value.children,
                                            editProductParam: widget.editProductParam,
                                          )));
                            }
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          Widget _buildBody() {
            return ListView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('Categories for you', style: TextStyle(color: colorGreyGaijin, fontSize: 15.0)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildCategoryButton('apparels'),
                      _buildCategoryButton('books'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildCategoryButton('electronics'),
                      _buildCategoryButton('footwear'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildCategoryButton('furnitures'),
                      _buildCategoryButton('kitchens'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildCategoryButton('sports'),
                      _buildCategoryButton('vehicles'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildCategoryButton('white_appliances'),
                      _buildCategoryButton('miscellaneous'),
                    ],
                  ),
                ),
              ],
            );
          }

          if (state is AddProductFetched) {
            if (state.response.data.profile != null && !state.response.data.profile.isSubscribed) {
              DataSession().setAddProductStatus(true);
              // Future.delayed(Duration.zero, () { Navigator. ... }); is a workarround for error...
              // ...Failed assertion: line 3364 pos 12: '!_debugLocked': is not true.)
              // https://stackoverflow.com/questions/58027568/another-exception-was-thrown-packageflutter-src-widgets-navigator-dart-fail
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AppBaseConfiguration(
                          page: BottomPage.page_4,
                        )));
              });
            }
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: _buildAppBar(),
                body: _buildBody(),
              ),
            );
          }

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: _buildAppBar(),
              body: Column(
                children: <Widget>[
                  Expanded(flex: 3, child: _buildBody()),
                  Expanded(child: SpinKitLoading()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
