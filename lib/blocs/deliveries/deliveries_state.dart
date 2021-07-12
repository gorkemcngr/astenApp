part of 'deliveries_bloc.dart';

abstract class DeliveriesState extends Equatable {
  const DeliveriesState();
}

class DeliveriesInitial extends DeliveriesState {
  @override
  List<Object> get props => [];
}

class DeliveriesLoadingState extends DeliveriesState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DeliveriesLoadedState extends DeliveriesState {
  final List<DeliveryList> deliveries;

  DeliveriesLoadedState({@required this.deliveries});
  @override
  // TODO: implement props
  List<Object> get props => [deliveries];
}

class DeliveriesErrorState extends DeliveriesState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
