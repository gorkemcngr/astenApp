import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_asten_app/data/orders_repository.dart';
import 'package:flutter_asten_app/models/order_detayM.dart';
import 'package:flutter_asten_app/models/order_list.dart';

import '../../locater.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository ordersRepository = getIt<OrdersRepository>();
  OrdersBloc() : super(OrdersInitial());

  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    if (event is FetchOrdersEvent) {
      yield OrdersLoadingState();
      try {
        final orders = await ordersRepository.getOrderList(event.page);

        yield OrdersLoadedState(orders: orders);
      } catch (_) {
        yield OrdersErrorState();
      }
    } else if (event is FetchMoreOrdersEvent) {
      try {
        final orders = await ordersRepository.getMoreOrderList(event.page);

        yield OrdersLoadedState(orders: orders);
      } catch (_) {
        yield OrdersErrorState();
      }
    } else if (event is SearchOrdersWithNameEvent) {
      try {
        final orders = await ordersRepository.getOrderListWithName(event.name);
        yield OrdersLoadedState(orders: orders);
      } catch (_) {
        yield OrdersErrorState();
      }
    } else if (event is SearchOpenOrdersWithNameEvent) {
      try {
        final orders =
            await ordersRepository.getOpenOrderListWithName(event.name);
        yield OrdersLoadedState(orders: orders);
      } catch (_) {
        yield OrdersErrorState();
      }
    } else if (event is FetchOpenOrdersEvent) {
      try {
        final orders = await ordersRepository.getOpenOrderList(event.page);
        yield OrdersLoadedState(orders: orders);
      } catch (_) {
        yield OrdersErrorState();
      }
    } else if (event is FetchMoreOpenOrdersEvent) {
      try {
        final orders = await ordersRepository.getMoreOpenOrderList(event.page);
        yield OrdersLoadedState(orders: orders);
      } catch (_) {
        yield OrdersErrorState();
      }
    }
  }
}
