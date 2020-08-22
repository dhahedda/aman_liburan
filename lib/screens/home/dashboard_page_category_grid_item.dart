import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:aman_liburan/blocs/dashboard/category/get_catalog_by_category_bloc.dart';
import 'package:aman_liburan/models/catalog_model.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/screens/detail_product/detail_product_page.dart';
import 'package:aman_liburan/utilities/widgets/create_product_item.dart';

class DashboardPageCategoryGridItem extends StatefulWidget {
  final String categoryId;
  DashboardPageCategoryGridItem({Key key, @required this.categoryId})
      : super(key: key);

  @override
  _DashboardPageCategoryGridItemState createState() =>
      _DashboardPageCategoryGridItemState(categoryId);
}

class _DashboardPageCategoryGridItemState
    extends State<DashboardPageCategoryGridItem> {
  final String categoryId;

  _DashboardPageCategoryGridItemState(this.categoryId);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildLoadingWidget() {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ],
      ));
    }

    Widget _buildErrorWidget(String error) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error"),
        ],
      ));
    }

    Widget _buildItemGrid(GlobalResponse response) {
      List<CatalogModel> listItem = [];
      List<ItemsResponse> productItems = response.data.items;
      for (var i = 0; i < productItems.length; i++) {
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

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: StaggeredGridView.countBuilder(
          physics: ClampingScrollPhysics(),
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

    return BlocProvider<GetCatalogByCategoryBloc>(
      create: (context) => GetCatalogByCategoryBloc()
        ..add(GetProductByCategoryEvent(id: categoryId)),
      child: BlocBuilder<GetCatalogByCategoryBloc, GetCatalogByCategoryState>(
          builder: (context, state) {
        Widget selectedWidget;
        if (state is OnLoading) {
          selectedWidget = _buildLoadingWidget();
        } else if (state is GetCatalogByCategoryResponse) {
          selectedWidget = _buildItemGrid(state.response);
        } else if (state is OnError) {
          print("Error => ${state.message}");
          selectedWidget = _buildErrorWidget("Error => ${state.message}");
        }
        return selectedWidget;
      }),
    );
  }
}