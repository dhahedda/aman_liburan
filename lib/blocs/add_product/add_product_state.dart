part of 'add_product_bloc.dart';

abstract class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object> get props => [];
}

class AddProductInit extends AddProductState {}

class AddProductLoading extends AddProductState {}

class AddProductFetched extends AddProductState {
  final GlobalResponse response;

  const AddProductFetched({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class AddProductSuccess extends AddProductState {
  final GlobalResponse response;

  const AddProductSuccess({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class EditProductSuccess extends AddProductState {
  final GlobalResponse response;

  const EditProductSuccess({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class AddProductError extends AddProductState {
  final String message;

  const AddProductError({@required this.message}) : assert(message != null);

  @override
  List<Object> get props => [message];
}
