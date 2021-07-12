import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_asten_app/data/deliveries_detay_repository.dart';
import 'package:flutter_asten_app/models/deliveriesM.dart';

import '../../locater.dart';

part 'deliveries_detay_event.dart';
part 'deliveries_detay_state.dart';

class DeliveriesDetayBloc
    extends Bloc<DeliveriesDetayEvent, DeliveriesDetayState> {
  final DeliveriesDetayRepository deliveriesDetayRepository =
      getIt<DeliveriesDetayRepository>();
  DeliveriesDetayBloc() : super(DeliveriesDetayInitial());

  @override
  Stream<DeliveriesDetayState> mapEventToState(
    DeliveriesDetayEvent event,
  ) async* {
    if (event is FetchDeliveriesDetayEvent) {
      yield DeliveriesDetayLoadingState();
      try {
        final deliveries =
            await deliveriesDetayRepository.getDeliveryListDetay(event.sednum);

        yield DeliveriesDetayLoadedState(deliveries: deliveries);
      } catch (_) {
        yield DeliveriesDetayErrorState();
      }
    }
  }
}
