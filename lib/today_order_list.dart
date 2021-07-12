import 'package:flutter/material.dart';
import 'blocs/todayorders/today_orders_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'TodayOrderDetay.dart';
import 'blocs/todayordersdetay/today_orders_detay_bloc.dart';

class TodayOrders extends StatefulWidget {
  @override
  _TodayOrdersState createState() => _TodayOrdersState();
}

class _TodayOrdersState extends State<TodayOrders> {
  var formKey = GlobalKey<FormState>();

  ScrollController _scrollController = ScrollController();
  int orderPage2 = 0;
  bool orderArama = false;

  var arananSiparis;
  var _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _ordersBloc = BlocProvider.of<TodayOrdersBloc>(context);
    _ordersBloc.add(FetchTodayOrdersEvent(page: orderPage2));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        orderPage2++;
        if (orderArama == false) {
          // _ordersBloc.add(FetchMoreTodayOrdersEvent(page: orderPage2));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _ordersBloc = BlocProvider.of<TodayOrdersBloc>(context);
    _ordersBloc.add(FetchTodayOrdersEvent(page: orderPage2));
    return Container(
      child: Column(
        children: [
          /* Container(
            height: 80,
            child: Center(
                 child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.95,
                 child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: _controller,
                    onChanged: (value) {
                      OpenOrderSearch(context, _ordersBloc);
                    },
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        suffixIcon: // add padding to adjust icon
                            IconButton(
                          onPressed: () {
                            _controller.clear();
                            orderArama = false;
                            orderPage2 = 0;
                            BlocProvider.of<TodayOrdersBloc>(context)
                                .add(FetchTodayOrdersEvent(page: orderPage2));
                          },
                          icon: Icon(Icons.clear),
                        ),
                        labelText: "Firma Adını veya Sipariş Numarası Giriniz",
                        hintText: "Firma Adı/Sipariş No",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: BorderRadius.circular(25)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onSaved: (value) {
                      arananSiparis = value;
                    },
                  ),
                ),
              ),
                ),
          ), */
          Expanded(
            child: BlocBuilder<TodayOrdersBloc, TodayOrdersState>(
              bloc: _ordersBloc,
              builder: (context, TodayOrdersState state) {
                if (state is TodayOrdersLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is TodayOrdersLoadedState) {
                  return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<
                                              TodayOrdersDetayBloc>(context),
                                          child: TodayOrderDetay(
                                            sidnum: state.orders[index].sidnum,
                                          ),
                                        )),
                              );
                            },
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.orders[index].sidnum.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(state.orders[index].firadi),
                              ],
                            ),
                            subtitle:
                                Text(state.orders[index].tarih.toString()),
                          ),
                        );
                      });
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void OpenOrderSearch(BuildContext context, TodayOrdersBloc _ordersBloc) {
    if (_controller.text.length != 0) {
      orderArama = true;
      orderPage2 = 0;
      BlocProvider.of<TodayOrdersBloc>(context)
          .add(SearchTodayOrdersWithNameEvent(name: _controller.text));
    } else {
      orderPage2 = 0;
      orderArama = false;
      _ordersBloc.add(FetchTodayOrdersEvent(page: orderPage2));
    }
  }
}
