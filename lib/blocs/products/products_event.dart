part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class FetchProductsEvent extends ProductsEvent {
  final int page;
  FetchProductsEvent({@required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class FetchMoreProductsEvent extends ProductsEvent {
  final int page;
  FetchMoreProductsEvent({@required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class SearchProductsWithNameEvent extends ProductsEvent {
  var name;

  SearchProductsWithNameEvent({@required this.name});
  @override
  // TODO: implement props
  List<Object> get props => [name];
}
