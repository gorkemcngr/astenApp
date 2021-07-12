import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_asten_app/data/today_orders_repository.dart';
import 'package:flutter_asten_app/models/today_ordersM.dart';

import '../../locater.dart';

part 'today_orders_event.dart';
part 'today_orders_state.dart';

class TodayOrdersBloc extends Bloc<TodayOrdersEvent, TodayOrdersState> {
  final TodayOrdersRepository ordersRepository = getIt<TodayOrdersRepository>();
  TodayOrdersBloc() : super(TodayOrdersInitial());

  @override
  Stream<TodayOrdersState> mapEventToState(
    TodayOrdersEvent event,
  ) async* {
    if (event is FetchTodayOrdersEvent) {
      yield TodayOrdersLoadingState();
      try {
        final orders = await ordersRepository.getTodayOrderList(event.page);

        yield TodayOrdersLoadedState(orders: orders);
      } catch (_) {
        yield TodayOrdersErrorState();
      }
    } else if (event is FetchMoreTodayOrdersEvent) {
      try {
        final orders = await ordersRepository.getMoreTodayOrderList(event.page);

        yield TodayOrdersLoadedState(orders: orders);
      } catch (_) {
        yield TodayOrdersErrorState();
      }
    } else if (event is SearchTodayOrdersWithNameEvent) {
      try {
        final orders =
            await ordersRepository.getTodayOrderListWithName(event.name);
        yield TodayOrdersLoadedState(orders: orders);
      } catch (_) {
        yield TodayOrdersErrorState();
      }
    }
  }
}
