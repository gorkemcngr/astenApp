part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
}

class OrdersInitial extends OrdersState {
  @override
  List<Object> get props => [];
}

class OrdersLoadingState extends OrdersState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OrdersLoadedState extends OrdersState {
  final List<OrderList> orders;

  OrdersLoadedState({@required this.orders});
  @override
  // TODO: implement props
  List<Object> get props => [orders];
}

class OrdersDetayLoadedState extends OrdersState {
  final List<OrderDetayM> orders;

  OrdersDetayLoadedState({@required this.orders});
  @override
  // TODO: implement props
  List<Object> get props => [orders];
}

class OrdersErrorState extends OrdersState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
