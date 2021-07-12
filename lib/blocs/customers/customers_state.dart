part of 'customers_bloc.dart';

abstract class CustomersState extends Equatable {
  const CustomersState();
}

class CustomersInitial extends CustomersState {
  @override
  List<Object> get props => [];
}

class CustomersLoadingState extends CustomersState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CustomersLoadedState extends CustomersState {
  final List<CustomerM> customers;

  CustomersLoadedState({@required this.customers});
  @override
  // TODO: implement props
  List<Object> get props => [customers];
}

class CustomersErrorState extends CustomersState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
