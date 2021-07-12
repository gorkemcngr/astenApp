part of 'customers_detay_bloc.dart';

abstract class CustomersDetayEvent extends Equatable {
  const CustomersDetayEvent();
}

class FetchCustomersDetayEvent extends CustomersDetayEvent {
  final String firkod;

  FetchCustomersDetayEvent({@required this.firkod});

  @override
  // TODO: implement props
  List<Object> get props => [firkod];
}
