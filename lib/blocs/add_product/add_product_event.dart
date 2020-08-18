part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends AddProductEvent {}

class AddProductPostEvent extends AddProductEvent {
  final AddProductParam addProductParam;

  AddProductPostEvent({this.addProductParam});

  @override
  List<Object> get props => [addProductParam];
}

class EditProductPostEvent extends AddProductEvent {
  final EditProductParam editProductParam;

  EditProductPostEvent({this.editProductParam});

  @override
  List<Object> get props => [editProductParam];
}
