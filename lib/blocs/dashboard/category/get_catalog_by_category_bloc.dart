import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/dashboard_repository.dart';

part 'get_catalog_by_category_event.dart';
part 'get_catalog_by_category_state.dart';

class GetCatalogByCategoryBloc extends Bloc<GetCatalogByCategoryEvent, GetCatalogByCategoryState> {
  @override
  GetCatalogByCategoryState get initialState => OnLoading();

  @override
  Stream<GetCatalogByCategoryState> mapEventToState(GetCatalogByCategoryEvent event) async* {
    if(event is GetProductByCategoryEvent){
      yield OnLoading();
      
      GlobalResponse response = await DashboardRepository().getProductCategory(categoryName: event.id);
      yield GetCatalogByCategoryResponse(response: response);
    }
  }
}
