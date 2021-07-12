part of 'orders_detay_bloc.dart';

abstract class OrdersDetayState extends Equatable {
  const OrdersDetayState();
}

class OrdersDetayInitial extends OrdersDetayState {
  @override
  List<Object> get props => [];
}

class OrdersDetayLoadingState extends OrdersDetayState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OrdersDetayLoadedState extends OrdersDetayState {
  final List<OrderDetayM> orders;

  OrdersDetayLoadedState({@required this.orders});
  @override
  // TODO: implement props
  List<Object> get props => [orders];
}

class OrdersDetayErrorState extends OrdersDetayState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
