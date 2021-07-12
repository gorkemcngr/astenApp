part of 'today_orders_bloc.dart';

abstract class TodayOrdersState extends Equatable {
  const TodayOrdersState();
}

class TodayOrdersInitial extends TodayOrdersState {
  @override
  List<Object> get props => [];
}

class TodayOrdersLoadingState extends TodayOrdersState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class TodayOrdersLoadedState extends TodayOrdersState {
  final List<TodayOrdersM> orders;

  TodayOrdersLoadedState({@required this.orders});
  @override
  // TODO: implement props
  List<Object> get props => [orders];
}

class TodayOrdersErrorState extends TodayOrdersState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
