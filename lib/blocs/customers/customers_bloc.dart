import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_asten_app/data/customers_repository.dart';
import 'package:flutter_asten_app/models/customerM.dart';

import '../../locater.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  final CustomersRepository customersRepository = getIt<CustomersRepository>();
  CustomersBloc() : super(CustomersInitial());

  @override
  Stream<CustomersState> mapEventToState(
    CustomersEvent event,
  ) async* {
    if (event is FetchCustomersEvent) {
      yield CustomersLoadingState();
      try {
        final customers = await customersRepository.getCustomerList(event.page);

        yield CustomersLoadedState(customers: customers);
      } catch (_) {
        yield CustomersErrorState();
      }
    } else if (event is FetchMoreCustomersEvent) {
      try {
        final customers =
            await customersRepository.getMoreCustomerList(event.page);

        yield CustomersLoadedState(customers: customers);
      } catch (_) {
        yield CustomersErrorState();
      }
    } else if (event is SearchCustomersWithNameEvent) {
      try {
        final customers =
            await customersRepository.getCustomerListWithName(event.name);
        yield CustomersLoadedState(customers: customers);
      } catch (_) {
        yield CustomersErrorState();
      }
    }
  }
}
