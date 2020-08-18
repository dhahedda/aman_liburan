part of 'get_catalog_by_category_bloc.dart';

abstract class GetCatalogByCategoryState extends Equatable {
  const GetCatalogByCategoryState();

 @override
  List<Object> get props => [];
}

class OnLoading extends GetCatalogByCategoryState {}

class GetCatalogByCategoryResponse extends GetCatalogByCategoryState {
  final GlobalResponse response;

  GetCatalogByCategoryResponse({@required this.response});

  @override
  List<Object> get props => [response];
}

class OnError extends GetCatalogByCategoryState {
 final String message;

  OnError({@required this.message});

  @override
  List<Object> get props => [message];
}