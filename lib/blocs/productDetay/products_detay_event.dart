part of 'products_detay_bloc.dart';

abstract class ProductsDetayEvent extends Equatable {
  const ProductsDetayEvent();
}

class FetchProductsDetayEvent extends ProductsDetayEvent {
  final String stkkod;

  FetchProductsDetayEvent({@required this.stkkod});

  @override
  // TODO: implement props
  List<Object> get props => [stkkod];
}
