import 'package:flutter/material.dart';
import 'package:flutter_asten_app/blocs/ordersdetay/orders_detay_bloc.dart';
import 'package:flutter_asten_app/order_detay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/orders/orders_bloc.dart';
import 'blocs/productDetay/products_detay_bloc.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var formKey = GlobalKey<FormState>();

  ScrollController _scrollController = ScrollController();
  int orderPage2 = 0;
  bool orderArama = false;
  bool openArama = true;
  var arananSiparis;
  var _controller = TextEditingController();
  bool isSwitched = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _ordersBloc = BlocProvider.of<OrdersBloc>(context);
    _ordersBloc.add(FetchOpenOrdersEvent(page: orderPage2));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        orderPage2++;
        if (orderArama == false) {
          if (openArama == true) {
            _ordersBloc.add(FetchMoreOpenOrdersEvent(page: orderPage2));
          } else {
            _ordersBloc.add(FetchMoreOrdersEvent(page: orderPage2));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _ordersBloc = BlocProvider.of<OrdersBloc>(context);

    return Container(
      child: Column(
        children: [
          Container(
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
                            BlocProvider.of<OrdersBloc>(context)
                                .add(FetchOrdersEvent(page: orderPage2));
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
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Sadece Açık Siparişleri Göster:",
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                    OpenOrderSearch(context, _ordersBloc);
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<OrdersBloc, OrdersState>(
              bloc: _ordersBloc,
              builder: (context, OrdersState state) {
                if (state is OrdersLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is OrdersLoadedState) {
                  print("girdi");
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
                                          value:
                                              BlocProvider.of<OrdersDetayBloc>(
                                                  context),
                                          child: OrderDetay(
                                            sidnum: state.orders[index].sidnum,
                                            openOrder: isSwitched,
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
                  print("asaasassasa");
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void OpenOrderSearch(BuildContext context, OrdersBloc _ordersBloc) {
    if (isSwitched == true) {
      if (_controller.text.length != 0) {
        orderArama = true;
        orderPage2 = 0;
        BlocProvider.of<OrdersBloc>(context)
            .add(SearchOpenOrdersWithNameEvent(name: _controller.text));
      } else {
        orderPage2 = 0;
        orderArama = false;
        openArama = true;
        _ordersBloc.add(FetchOpenOrdersEvent(page: orderPage2));
      }
    } else {
      if (_controller.text.length != 0) {
        orderArama = true;
        orderPage2 = 0;
        BlocProvider.of<OrdersBloc>(context)
            .add(SearchOrdersWithNameEvent(name: _controller.text));
      } else {
        orderPage2 = 0;
        orderArama = false;
        openArama = false;
        _ordersBloc.add(FetchOrdersEvent(page: orderPage2));
      }
    }
  }
}
