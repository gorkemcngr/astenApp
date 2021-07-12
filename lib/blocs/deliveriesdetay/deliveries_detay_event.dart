part of 'deliveries_detay_bloc.dart';

abstract class DeliveriesDetayEvent extends Equatable {
  const DeliveriesDetayEvent();
}

class FetchDeliveriesDetayEvent extends DeliveriesDetayEvent {
  final int sednum;

  FetchDeliveriesDetayEvent({@required this.sednum});

  @override
  // TODO: implement props
  List<Object> get props => [sednum];
}
