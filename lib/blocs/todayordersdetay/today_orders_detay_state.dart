part of 'today_orders_detay_bloc.dart';

abstract class TodayOrdersDetayState extends Equatable {
  const TodayOrdersDetayState();
}

class TodayOrdersDetayInitial extends TodayOrdersDetayState {
  @override
  List<Object> get props => [];
}

class OrdersDetayLoadingState extends TodayOrdersDetayState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class TodayOrdersDetayLoadedState extends TodayOrdersDetayState {
  final List<TodayOrderDetayM> orders;

  TodayOrdersDetayLoadedState({@required this.orders});
  @override
  // TODO: implement props
  List<Object> get props => [orders];
}

class TodayOrdersDetayErrorState extends TodayOrdersDetayState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
