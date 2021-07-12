import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asten_app/data/deliveries_repository.dart';
import 'package:flutter_asten_app/models/delivery_list.dart';

import '../../locater.dart';

part 'deliveries_event.dart';
part 'deliveries_state.dart';

class DeliveriesBloc extends Bloc<DeliveriesEvent, DeliveriesState> {
  final DeliveriesRepository deliveriesRepository =
      getIt<DeliveriesRepository>();
  DeliveriesBloc() : super(DeliveriesInitial());

  @override
  Stream<DeliveriesState> mapEventToState(
    DeliveriesEvent event,
  ) async* {
    if (event is FetchDeliveriesEvent) {
      yield DeliveriesLoadingState();
      try {
        final deliveries =
            await deliveriesRepository.getDeliveryList(event.page);
        print(deliveries[1].firadi);
        yield DeliveriesLoadedState(deliveries: deliveries);
      } catch (_) {
        yield DeliveriesErrorState();
      }
    } else if (event is FetchMoreDeliveriesEvent) {
      try {
        final deliveries =
            await deliveriesRepository.getMoreDeliveryList(event.page);
        print(deliveries[1].firadi);
        yield DeliveriesLoadedState(deliveries: deliveries);
      } catch (_) {
        yield DeliveriesErrorState();
      }
    } else if (event is SearchDeliveriesWithNameEvent) {
      try {
        final deliveries =
            await deliveriesRepository.getDeliveryListWithName(event.name);
        yield DeliveriesLoadedState(deliveries: deliveries);
      } catch (_) {
        yield DeliveriesErrorState();
      }
    }
  }
}
