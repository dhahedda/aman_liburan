part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ProductListInitiateEvent extends ProductListEvent {}

class ProductListEditEvent extends ProductListEvent {
  final String productId;

  const ProductListEditEvent({@required this.productId}) : assert(productId != null);

  @override
  List<Object> get props => [productId];
}

class ProductListUpdatePriceEvent extends ProductListEvent {
  final String productId;
  final int productNewPrice;

  const ProductListUpdatePriceEvent({@required this.productId, @required this.productNewPrice})
      : assert(productId != null),
        assert(productNewPrice != null);

  @override
  List<Object> get props => [productId, productNewPrice];
}

class ProductListMarkAsSoldEvent extends ProductListEvent {
  final String productId;

  const ProductListMarkAsSoldEvent({@required this.productId})
      : assert(productId != null);

  @override
  List<Object> get props => [productId];
}
