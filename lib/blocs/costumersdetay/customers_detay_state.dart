part of 'customers_detay_bloc.dart';

abstract class CustomersDetayState extends Equatable {
  const CustomersDetayState();
}

class CustomersDetayInitial extends CustomersDetayState {
  @override
  List<Object> get props => [];
}

class CustomersDetayLoadingState extends CustomersDetayState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CustomersDetayLoadedState extends CustomersDetayState {
  final List<CustomerDetayM> customers;

  CustomersDetayLoadedState({@required this.customers});
  @override
  // TODO: implement props
  List<Object> get props => [customers];
}

class CustomersDetayErrorState extends CustomersDetayState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
