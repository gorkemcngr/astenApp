part of 'customers_bloc.dart';

abstract class CustomersEvent extends Equatable {
  const CustomersEvent();
}

class FetchCustomersEvent extends CustomersEvent {
  final int page;
  FetchCustomersEvent({@required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class FetchMoreCustomersEvent extends CustomersEvent {
  final int page;
  FetchMoreCustomersEvent({@required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class SearchCustomersWithNameEvent extends CustomersEvent {
  var name;

  SearchCustomersWithNameEvent({@required this.name});
  @override
  // TODO: implement props
  List<Object> get props => [name];
}
