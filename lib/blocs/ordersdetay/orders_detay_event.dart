part of 'orders_detay_bloc.dart';

abstract class OrdersDetayEvent extends Equatable {
  const OrdersDetayEvent();
}

class FetchOrdersDetayEvent extends OrdersDetayEvent {
  final int sidnum;

  FetchOrdersDetayEvent({@required this.sidnum});

  @override
  // TODO: implement props
  List<Object> get props => [sidnum];
}

class FetchOpenOrdersDetayEvent extends OrdersDetayEvent {
  final int sidnum;

  FetchOpenOrdersDetayEvent({@required this.sidnum});

  @override
  // TODO: implement props
  List<Object> get props => [sidnum];
}
