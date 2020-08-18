import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:aman_liburan/components/data_session.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/add_product_repository.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  @override
  AddProductState get initialState => AddProductInit();

  @override
  Stream<AddProductState> mapEventToState(AddProductEvent event) async* {
    if (event is InitEvent) {
      try {
        final response = await AddProductRepository().getCategories();
        final isSubscribed = await DataSession().getSubscriptionStatus();
        response.data.profile = ProfileResponse(isSubscribed:isSubscribed);
        yield AddProductFetched(response: response);
      } catch (error) {
        yield AddProductError(message: error.toString());
      }
    }
    if (event is AddProductPostEvent) {
      yield AddProductLoading();
      try {
        final response = await AddProductRepository().postAddProduct(params: event.addProductParam);
        yield AddProductSuccess(response: response);
      } catch (error) {
        yield AddProductError(message: error.toString());
      }
    }
    if (event is EditProductPostEvent) {
      yield AddProductLoading();
      try {
        final response = await AddProductRepository().postEditProduct(params: event.editProductParam);
        yield EditProductSuccess(response: response);
      } catch (error) {
        yield AddProductError(message: error.toString());
      }
    }
  }
}
