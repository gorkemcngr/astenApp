part of 'today_orders_detay_bloc.dart';

abstract class TodayOrdersDetayEvent extends Equatable {
  const TodayOrdersDetayEvent();
}

class FetchTodayOrdersDetayEvent extends TodayOrdersDetayEvent {
  final int sidnum;

  FetchTodayOrdersDetayEvent({@required this.sidnum});

  @override
  // TODO: implement props
  List<Object> get props => [sidnum];
}
