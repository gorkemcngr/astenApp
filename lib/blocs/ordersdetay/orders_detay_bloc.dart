import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asten_app/data/orders_detay_repository.dart';
import 'package:flutter_asten_app/models/order_detayM.dart';

import '../../locater.dart';

part 'orders_detay_event.dart';
part 'orders_detay_state.dart';

class OrdersDetayBloc extends Bloc<OrdersDetayEvent, OrdersDetayState> {
  final OrdersDetayRepository ordersDetayRepository =
      getIt<OrdersDetayRepository>();
  OrdersDetayBloc() : super(OrdersDetayInitial());

  @override
  Stream<OrdersDetayState> mapEventToState(
    OrdersDetayEvent event,
  ) async* {
    if (event is FetchOrdersDetayEvent) {
      yield OrdersDetayLoadingState();
      try {
        final orders =
            await ordersDetayRepository.getOrderListDetay(event.sidnum);

        yield OrdersDetayLoadedState(orders: orders);
      } catch (_) {
        yield OrdersDetayErrorState();
      }
    } else if (event is FetchOpenOrdersDetayEvent) {
      yield OrdersDetayLoadingState();
      try {
        final orders =
            await ordersDetayRepository.getOpenOrderListDetay(event.sidnum);

        yield OrdersDetayLoadedState(orders: orders);
      } catch (_) {
        yield OrdersDetayErrorState();
      }
    }
  }
}
