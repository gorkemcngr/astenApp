import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asten_app/auth_service.dart';
import 'package:flutter_asten_app/blocs/deliveries/deliveries_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'SplashImage.dart';
import 'blocs/costumersdetay/customers_detay_bloc.dart';
import 'blocs/customers/customers_bloc.dart';
import 'blocs/deliveriesdetay/deliveries_detay_bloc.dart';
import 'blocs/orders/orders_bloc.dart';
import 'blocs/ordersdetay/orders_detay_bloc.dart';
import 'blocs/productDetay/products_detay_bloc.dart';
import 'blocs/products/products_bloc.dart';
import 'blocs/todayorders/today_orders_bloc.dart';
import 'blocs/todayordersdetay/today_orders_detay_bloc.dart';
import 'locater.dart';
import 'main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "asten app",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 30, 101, 177),
          fontFamily: "Roboto-Regular"),
      home: MultiProvider(
        providers: [
          BlocProvider<OrdersDetayBloc>(create: (_) => OrdersDetayBloc()),
          BlocProvider<TodayOrdersDetayBloc>(
              create: (_) => TodayOrdersDetayBloc()),
          BlocProvider<CustomersBloc>(create: (_) => CustomersBloc()),
          BlocProvider<CustomersDetayBloc>(create: (_) => CustomersDetayBloc()),
          BlocProvider<ProductsBloc>(create: (_) => ProductsBloc()),
          BlocProvider<ProductsDetayBloc>(create: (_) => ProductsDetayBloc()),
          BlocProvider<DeliveriesDetayBloc>(
              create: (_) => DeliveriesDetayBloc()),
          BlocProvider<DeliveriesBloc>(create: (_) => DeliveriesBloc()),
          BlocProvider<OrdersBloc>(create: (context) => OrdersBloc()),
          BlocProvider<TodayOrdersBloc>(create: (context) => TodayOrdersBloc()),
          ChangeNotifierProvider(create: (_) => AuthService())
        ],
        child: MainPage(),
      ),
    );
  }
}
