import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:aman_liburan/models/catalog_model.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/screens/detail_product/detail_product_page.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/widgets/create_product_item.dart';

class AccountSellerCollection extends StatefulWidget {
  final GlobalResponse response;

  const AccountSellerCollection({Key key, this.response}) : super(key: key);

  @override
  _AccountSellerCollectionState createState() =>
      _AccountSellerCollectionState(response);
}

class _AccountSellerCollectionState extends State<AccountSellerCollection> {
  final GlobalResponse response;

  _AccountSellerCollectionState(this.response);

  Widget _buildItemGrid(GlobalResponse response) {
    List<CatalogModel> listItem = [];
    List<ItemsResponse> productItems = response.data.collections;
    for (var i = 0; i < response.data.collections.length; i++) {
      listItem.add(
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
    }

    return SliverPadding(
      padding: EdgeInsets.all(8.0),
      sliver: SliverStaggeredGrid.countBuilder(
        crossAxisCount: 4,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        itemBuilder: (context, index) => CreateProductItem(
          catalogModel: listItem[index],
          onTapDetail: () {
            print("Detail Clicked!");

            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailProductPage(
                  productId: listItem[index].id,
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
        itemCount: listItem.length,
      ),
    );
  }

  Widget _buildContent(GlobalResponse response) {
    if (response.data.collections.length > 0) {
      return CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          _buildItemGrid(response),
        ],
      );
    } else {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: SizeConfig.getWidth(context),
          height: SizeConfig.getHeight(context),
          color: Colors.white,
          padding: EdgeInsets.only(top: 30.0),
          child: Text(
            "No Data",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 1,
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              fontFamily: "Nunito",
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(response);
  }
}