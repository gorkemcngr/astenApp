part of 'products_detay_bloc.dart';

abstract class ProductsDetayState extends Equatable {
  const ProductsDetayState();
}

class ProductsDetayInitial extends ProductsDetayState {
  @override
  List<Object> get props => [];
}

class ProductsDetayLoadingState extends ProductsDetayState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ProductsDetayLoadedState extends ProductsDetayState {
  final List<ProductDetayM> products;

  ProductsDetayLoadedState({@required this.products});
  @override
  // TODO: implement props
  List<Object> get props => [products];
}

class ProductsDetayErrorState extends ProductsDetayState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
