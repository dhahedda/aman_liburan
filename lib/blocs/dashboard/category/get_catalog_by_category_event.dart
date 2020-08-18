part of 'get_catalog_by_category_bloc.dart';

abstract class GetCatalogByCategoryEvent extends Equatable {
  const GetCatalogByCategoryEvent();

   @override
  List<Object> get props => [];
}

class GetProductByCategoryEvent extends GetCatalogByCategoryEvent {
  final String id;

  GetProductByCategoryEvent({this.id});

  @override
  List<Object> get props => [id];
}
