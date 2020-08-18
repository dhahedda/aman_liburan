import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/param/search_param.dart';

import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/account_repository.dart';
import 'package:aman_liburan/repositories/detail_product_repository.dart';
import 'package:aman_liburan/repositories/product_list_repository.dart';
import 'package:aman_liburan/repositories/search_repository.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  @override
  ProductListState get initialState => ProductListInit();

  @override
  Stream<ProductListState> mapEventToState(ProductListEvent event) async* {
    if (event is ProductListInitiateEvent) {
      yield ProductListLoading();
      try {
        final GlobalResponse profileResponse = await AccountRepository().getProfileInfo();
        final GlobalResponse searchResponse = await SearchRepository().getSearch(
          params: SearchParam(userId: profileResponse.data.profile.id),
        );
        yield ProductListResponse(productList: searchResponse.data.items);
      } catch (error) {
        yield ProductListError(message: error.toString());
      }
    }
    if (event is ProductListEditEvent) {
      yield ProductListApiLoading();
      try {
        final GlobalResponse response = await DetailProductRepository().getDetailProduct(
          params: DetailProductParam(id: event.productId),
        );
        yield ProductListEditNavigated(response: response);
      } catch (error) {
        yield ProductListError(message: error.toString());
      }
    }
    if (event is ProductListUpdatePriceEvent) {
      yield ProductListApiLoading();
      try {
        final GlobalResponse response = await ProductListRepository().postEditPricing(
            params: EditPricingParam(
          id: event.productId,
          price: event.productNewPrice,
        ));
        yield ProductListPriceUpdated(response: response);
      } catch (e) {
        yield ProductListError(message: e.toString());
      }
    }
    if (event is ProductListMarkAsSoldEvent) {
      yield ProductListApiLoading();
      try {
        final GlobalResponse response = await ProductListRepository().postMarkAsSold(
            params: MarkAsSoldParam(
          id: event.productId,
        ));
        yield ProductListPriceUpdated(response: response);
      } catch (e) {
        yield ProductListError(message: e.toString());
      }
    }
  }
}
