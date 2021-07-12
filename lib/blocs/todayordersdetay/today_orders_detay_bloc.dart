import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_asten_app/data/today_orders_detay_repository.dart';
import 'package:flutter_asten_app/models/today_orders_detayM.dart';

import '../../locater.dart';

part 'today_orders_detay_event.dart';
part 'today_orders_detay_state.dart';

class TodayOrdersDetayBloc
    extends Bloc<TodayOrdersDetayEvent, TodayOrdersDetayState> {
  final TodayOrdersDetayRepository ordersDetayRepository =
      getIt<TodayOrdersDetayRepository>();
  TodayOrdersDetayBloc() : super(TodayOrdersDetayInitial());

  @override
  Stream<TodayOrdersDetayState> mapEventToState(
    TodayOrdersDetayEvent event,
  ) async* {
    if (event is FetchTodayOrdersDetayEvent) {
      yield OrdersDetayLoadingState();
      try {
        final orders = await ordersDetayRepository
            .getTodayOrderDetayListDetay(event.sidnum);

        yield TodayOrdersDetayLoadedState(orders: orders);
      } catch (_) {
        yield TodayOrdersDetayErrorState();
      }
    }
  }
}
