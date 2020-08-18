part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListInit extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListApiLoading extends ProductListState {}

class ProductListResponse extends ProductListState {
  final List<ItemsResponse> productList;

  const ProductListResponse({@required this.productList}) : assert(productList != null);

  @override
  List<Object> get props => [productList];
}

class ProductListError extends ProductListState {
  final String message;

  const ProductListError({@required this.message}) : assert(message != null);

  @override
  List<Object> get props => [message];
}

class ProductListPriceUpdated extends ProductListState {
  final GlobalResponse response;

  ProductListPriceUpdated({this.response});

  @override
  List<Object> get props => [response];
}

class ProductListEditNavigated extends ProductListState {
  final GlobalResponse response;

  ProductListEditNavigated({this.response});

  @override
  List<Object> get props => [response];
}
