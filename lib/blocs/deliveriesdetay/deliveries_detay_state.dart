part of 'deliveries_detay_bloc.dart';

abstract class DeliveriesDetayState extends Equatable {
  const DeliveriesDetayState();
}

class DeliveriesDetayInitial extends DeliveriesDetayState {
  @override
  List<Object> get props => [];
}

class DeliveriesDetayLoadingState extends DeliveriesDetayState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DeliveriesDetayLoadedState extends DeliveriesDetayState {
  final List<DeliveriesM> deliveries;

  DeliveriesDetayLoadedState({@required this.deliveries});
  @override
  // TODO: implement props
  List<Object> get props => [deliveries];
}

class DeliveriesDetayErrorState extends DeliveriesDetayState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
