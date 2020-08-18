import 'package:flutter/material.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/dashboard/categories_response.dart';
import 'package:aman_liburan/screens/add_product/add_product_3rd_page.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';

class AddProduct2ndPage extends StatefulWidget {
  final bool isEditProduct;
  final List<CategoriesResponse> listCategoriesResponse;
  final EditProductParam editProductParam;

  AddProduct2ndPage({
    Key key,
    @required this.isEditProduct,
    @required this.listCategoriesResponse,
    this.editProductParam,
  }) : super(key: key);

  @override
  _AddProduct2ndPageState createState() => _AddProduct2ndPageState();
}

class _AddProduct2ndPageState extends State<AddProduct2ndPage> {
  EditProductParam _editProductParam;

  @override
  void initState() {
    super.initState();
    _editProductParam = widget.editProductParam;
  }

  @override
  void dispose() {
    super.dispose();
  }

  String dateTimeToTimeString(DateTime dateTime) => dateTime.toString().split(' ')[1].substring(0, 5);

  @override
  Widget build(BuildContext context) {
    Widget _buildAppBar() {
      return AppBar(
        title: Text('Choose new category for the item', style: TextStyle(fontSize: 19.0, color: Colors.black87, fontWeight: FontWeight.bold)),
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

    Widget _buildCategoryTile(CategoriesResponse categoriesResponse) {
      return InkWell(
        onTap: () {
          if (widget.isEditProduct) {
            _editProductParam.product.categoryIds = [categoriesResponse.id];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProduct3rdPage(
                  isEditProduct: widget.isEditProduct,
                  editProductParam: _editProductParam,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProduct3rdPage(
                  isEditProduct: widget.isEditProduct,
                  addProductParam: AddProductParam(
                    product: ProductWithoutId(categoryIds: [categoriesResponse.id]),
                    productDetail: ProductDetail(),
                    productImages: [],
                  ),
                ),
              ),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Text(categoriesResponse.name, style: TextStyle(fontSize: 18.0)),
            ),
            Divider(thickness: 1, height: 1),
          ],
        ),
      );
    }

    Widget _buildBody() {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: widget.listCategoriesResponse.length,
        itemBuilder: (context, index) {
          return _buildCategoryTile(widget.listCategoriesResponse[index]);
        },
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }
}
