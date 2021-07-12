import 'package:get_it/get_it.dart';

import 'data/customers_detay_repository.dart';
import 'data/customers_repository.dart';
import 'data/deliveries_detay_repository.dart';
import 'data/deliveries_repository.dart';
import 'data/orders_detay_repository.dart';
import 'data/orders_repository.dart';
import 'data/products_detay_repository.dart';
import 'data/products_repository.dart';
import 'data/today_orders_detay_repository.dart';
import 'data/today_orders_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => OrdersRepository());
  getIt.registerLazySingleton(() => TodayOrdersRepository());
  getIt.registerLazySingleton(() => TodayOrdersDetayRepository());
  getIt.registerLazySingleton(() => OrdersDetayRepository());
  getIt.registerLazySingleton(() => DeliveriesRepository());
  getIt.registerLazySingleton(() => DeliveriesDetayRepository());
  getIt.registerLazySingleton(() => CustomersRepository());
  getIt.registerLazySingleton(() => CustomersDetayRepository());
  getIt.registerLazySingleton(() => ProductsRepository());
  getIt.registerLazySingleton(() => ProductsDetayRepository());
}
