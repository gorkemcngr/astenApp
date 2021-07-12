part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoadingState extends ProductsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ProductsLoadedState extends ProductsState {
  final List<ProductM> products;

  ProductsLoadedState({@required this.products});
  @override
  // TODO: implement props
  List<Object> get props => [products];
}

class ProductsErrorState extends ProductsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
