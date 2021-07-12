part of 'today_orders_bloc.dart';

abstract class TodayOrdersEvent extends Equatable {
  const TodayOrdersEvent();
}

class FetchTodayOrdersEvent extends TodayOrdersEvent {
  final int page;
  FetchTodayOrdersEvent({@required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class FetchMoreTodayOrdersEvent extends TodayOrdersEvent {
  final int page;
  FetchMoreTodayOrdersEvent({@required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class SearchTodayOrdersWithNameEvent extends TodayOrdersEvent {
  var name;

  SearchTodayOrdersWithNameEvent({@required this.name});
  @override
  // TODO: implement props
  List<Object> get props => [name];
}
