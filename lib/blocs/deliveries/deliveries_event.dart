part of 'deliveries_bloc.dart';

abstract class DeliveriesEvent extends Equatable {
  const DeliveriesEvent();
}

class FetchDeliveriesEvent extends DeliveriesEvent {
  final int page;
  FetchDeliveriesEvent({@required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class FetchMoreDeliveriesEvent extends DeliveriesEvent {
  final int page;
  FetchMoreDeliveriesEvent({@required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class SearchDeliveriesWithNameEvent extends DeliveriesEvent {
  var name;

  SearchDeliveriesWithNameEvent({@required this.name});
  @override
  // TODO: implement props
  List<Object> get props => [name];
}
