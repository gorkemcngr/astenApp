import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_asten_app/data/customers_detay_repository.dart';
import 'package:flutter_asten_app/models/customers_detayM.dart';

import '../../locater.dart';

part 'customers_detay_event.dart';
part 'customers_detay_state.dart';

class CustomersDetayBloc
    extends Bloc<CustomersDetayEvent, CustomersDetayState> {
  final CustomersDetayRepository deliveriesDetayRepository =
      getIt<CustomersDetayRepository>();
  CustomersDetayBloc() : super(CustomersDetayInitial());

  @override
  Stream<CustomersDetayState> mapEventToState(
    CustomersDetayEvent event,
  ) async* {
    if (event is FetchCustomersDetayEvent) {
      yield CustomersDetayLoadingState();
      try {
        final customers =
            await deliveriesDetayRepository.getCustomerListDetay(event.firkod);

        yield CustomersDetayLoadedState(customers: customers);
      } catch (_) {
        yield CustomersDetayErrorState();
      }
    }
  }
}
