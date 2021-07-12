part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class FetchOrdersEvent extends OrdersEvent {
  final int page;
  FetchOrdersEvent({@required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class FetchOpenOrdersEvent extends OrdersEvent {
  final int page;
  FetchOpenOrdersEvent({@required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class FetchMoreOrdersEvent extends OrdersEvent {
  final int page;
  FetchMoreOrdersEvent({@required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class FetchMoreOpenOrdersEvent extends OrdersEvent {
  final int page;
  FetchMoreOpenOrdersEvent({@required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class SearchOpenOrdersWithNameEvent extends OrdersEvent {
  var name;

  SearchOpenOrdersWithNameEvent({@required this.name});
  @override
  // TODO: implement props
  List<Object> get props => [name];
}

class SearchOrdersWithNameEvent extends OrdersEvent {
  var name;

  SearchOrdersWithNameEvent({@required this.name});
  @override
  // TODO: implement props
  List<Object> get props => [name];
}

class FetchOrdersDetayEventt extends OrdersEvent {
  final int sidnum;

  FetchOrdersDetayEventt({@required this.sidnum});

  @override
  // TODO: implement props
  List<Object> get props => [sidnum];
}
