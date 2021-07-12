import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'blocs/todayordersdetay/today_orders_detay_bloc.dart';
import 'package:flutter_asten_app/product_detay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'auth_service.dart';

import 'package:turkish/turkish.dart' as turk;

import 'blocs/productDetay/products_detay_bloc.dart';

class TodayOrderDetay extends StatefulWidget {
  final int sidnum;

  TodayOrderDetay({this.sidnum});

  @override
  _TodayOrderDetayState createState() => _TodayOrderDetayState();
}

class _TodayOrderDetayState extends State<TodayOrderDetay> {
  bool geriDon;
  int toplam = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final _ordersDetayBloc = BlocProvider.of<TodayOrdersDetayBloc>(context);

    _ordersDetayBloc.add(FetchTodayOrdersDetayEvent(sidnum: widget.sidnum));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<ProductsDetayBloc>(create: (_) => ProductsDetayBloc()),
        ChangeNotifierProvider(create: (_) => AuthService())
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detay Sayfası"),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return AppBody(context);
          } else {
            return AppBodyLandScape(context);
          }
        }),
      ),
    );
  }

  Container AppBody(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final _ordersDetayBloc = BlocProvider.of<TodayOrdersDetayBloc>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: BlocBuilder(
        bloc: _ordersDetayBloc,
        builder: (context, TodayOrdersDetayState state) {
          if (state is OrdersDetayLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodayOrdersDetayLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (state as TodayOrdersDetayLoadedState)
                          .orders[0]
                          .sidnum
                          .toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (state as TodayOrdersDetayLoadedState).orders[0].tarih,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Firma Adı : ',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: (state as TodayOrdersDetayLoadedState)
                              .orders[0]
                              .firadi,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ]),
                ),
                Divider(
                  height: 0.5,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Sipariş Numarası : ',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: (state as TodayOrdersDetayLoadedState)
                              .orders[0]
                              .sidnum
                              .toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ]),
                ),
                Divider(
                  height: 0.5,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Siparişler",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                              itemCount: (state as TodayOrdersDetayLoadedState)
                                  .orders
                                  .length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shadowColor: Colors.blue,
                                  elevation: 4,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                    value: BlocProvider.of<
                                                            ProductsDetayBloc>(
                                                        context),
                                                    child: ProductDetay(
                                                      stkkod: state
                                                          .orders[index].sidtj,
                                                    ),
                                                  )));
                                    },
                                    title: Text(
                                        (state as TodayOrdersDetayLoadedState)
                                            .orders[index]
                                            .stkadi
                                            .toString()),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                          height: 0.7,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Stok Kodu  : ',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: (state
                                                          as TodayOrdersDetayLoadedState)
                                                      .orders[index]
                                                      .sidstk
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ]),
                                        ),
                                        Divider(
                                          height: 0.7,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Sipariş Miktarı  : ',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      ((state as TodayOrdersDetayLoadedState)
                                                              .orders[index]
                                                              .sidmik)
                                                          .toInt()
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ]),
                                        ),
                                        Divider(
                                          height: 0.7,
                                        ),
                                        myAuth.durum ==
                                                KullaniciDurumu.OturumAcilmis
                                            ? RichText(
                                                text: TextSpan(
                                                    text: 'Sipariş Tutarı  : ',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: (state
                                                                as TodayOrdersDetayLoadedState)
                                                            .orders[index]
                                                            .sidtut
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ]),
                                              )
                                            : Text(""),
                                        myAuth.durum ==
                                                KullaniciDurumu.OturumAcilmis
                                            ? Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    _showMyDialog(
                                                            0,
                                                            (state as TodayOrdersDetayLoadedState)
                                                                .orders[index]
                                                                .sidsno)
                                                        .then((value) {
                                                      sleep(const Duration(
                                                          milliseconds: 300));
                                                      if (geriDon == true) {
                                                        Navigator.pop(context);
                                                      } else {
                                                        null;
                                                      }
                                                    });
                                                  },
                                                  child: Text(
                                                      "Bugün Listesinden Çıkar"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.redAccent),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    )

                                    /*Text(
                                      "Stok Kodu : ${(state as OrdersDetayLoadedState).orders[index].sidstk} \nSipariş Miktarı : ${((state as OrdersDetayLoadedState).orders[index].sidmik).toInt()} \nSipariş Tutarı : ${((state as OrdersDetayLoadedState).orders[index].sidtut).toStringAsFixed(2)}",
                                      style: TextStyle(color: Colors.black),
                                    )*/
                                    ,
                                  ),
                                );
                              }),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7)),
                        ),
                        child: myAuth.durum == KullaniciDurumu.OturumAcilmis
                            ? Text(
                                "  Toplam Tutar: " +
                                    (state as TodayOrdersDetayLoadedState)
                                        .orders[0]
                                        .toplam
                                        .toStringAsFixed(2) +
                                    (state as TodayOrdersDetayLoadedState)
                                        .orders[0]
                                        .typeOfMoney,
                                style: TextStyle(fontSize: 25),
                              )
                            : Text(""),
                      ),
                    ],
                  ),
                )),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget AppBodyLandScape(BuildContext context) {
    final _ordersDetayBloc = BlocProvider.of<TodayOrdersDetayBloc>(context);
    final myAuth = Provider.of<AuthService>(context);
    return BlocBuilder(
      bloc: _ordersDetayBloc,
      builder: (context, TodayOrdersDetayState state) {
        if (state is OrdersDetayLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TodayOrdersDetayLoadedState) {
          return Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 2.2,
                margin: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (state as TodayOrdersDetayLoadedState)
                              .orders[0]
                              .sidnum
                              .toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          (state as TodayOrdersDetayLoadedState)
                              .orders[0]
                              .tarih,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Firma Adı : ',
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: (state as TodayOrdersDetayLoadedState)
                                  .orders[0]
                                  .firadi,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ]),
                    ),
                    Divider(
                      height: 0.5,
                    ),

                    RichText(
                      text: TextSpan(
                          text: 'Sipariş Numarası : ',
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: (state as TodayOrdersDetayLoadedState)
                                  .orders[0]
                                  .sidnum
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ]),
                    ),
                    Divider(
                      height: 0.5,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    //////////////////////////////////////////////////////////////////////////////
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Siparişler",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  child: ListView.builder(
                                      itemCount:
                                          (state as TodayOrdersDetayLoadedState)
                                              .orders
                                              .length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          shadowColor: Colors.blue,
                                          elevation: 4,
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          BlocProvider.value(
                                                            value: BlocProvider
                                                                .of<ProductsDetayBloc>(
                                                                    context),
                                                            child: ProductDetay(
                                                              stkkod: state
                                                                  .orders[index]
                                                                  .sidtj,
                                                            ),
                                                          )));
                                            },
                                            title: Text((state
                                                    as TodayOrdersDetayLoadedState)
                                                .orders[index]
                                                .stkadi
                                                .toString()),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Divider(
                                                  height: 0.7,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                      text: 'Stok Kodu  : ',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: (state
                                                                  as TodayOrdersDetayLoadedState)
                                                              .orders[index]
                                                              .sidstk
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ]),
                                                ),
                                                Divider(
                                                  height: 0.7,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                      text:
                                                          'Sipariş Miktarı  : ',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: ((state
                                                                      as TodayOrdersDetayLoadedState)
                                                                  .orders[index]
                                                                  .sidmik)
                                                              .toInt()
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ]),
                                                ),
                                                Divider(
                                                  height: 0.7,
                                                ),
                                                myAuth.durum ==
                                                        KullaniciDurumu
                                                            .OturumAcilmis
                                                    ? RichText(
                                                        text: TextSpan(
                                                            text:
                                                                'Sipariş Tutarı  : ',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                text: (state
                                                                        as TodayOrdersDetayLoadedState)
                                                                    .orders[
                                                                        index]
                                                                    .sidtut
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ]),
                                                      )
                                                    : Text(""),
                                                Divider(
                                                  height: 0.7,
                                                ),
                                                myAuth.durum ==
                                                        KullaniciDurumu
                                                            .OturumAcilmis
                                                    ? Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            _showMyDialog(
                                                                    0,
                                                                    (state as TodayOrdersDetayLoadedState)
                                                                        .orders[
                                                                            index]
                                                                        .sidsno)
                                                                .then((value) {
                                                              sleep(const Duration(
                                                                  milliseconds:
                                                                      150));
                                                              if (geriDon ==
                                                                  true) {
                                                                Navigator.pop(
                                                                    context);
                                                              } else {
                                                                null;
                                                              }
                                                            });
                                                          },
                                                          child: Text(
                                                              "Bugün Listesinden Çıkar"),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary: Colors
                                                                      .redAccent),
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            )

                                            /*Text(
                                      "Stok Kodu : ${(state as OrdersDetayLoadedState).orders[index].sidstk} \nSipariş Miktarı : ${((state as OrdersDetayLoadedState).orders[index].sidmik).toInt()} \nSipariş Tutarı : ${((state as OrdersDetayLoadedState).orders[index].sidtut).toStringAsFixed(2)}",
                                      style: TextStyle(color: Colors.black),
                                    )*/
                                            ,
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(7),
                                      bottomRight: Radius.circular(7)),
                                ),
                                child: myAuth.durum ==
                                        KullaniciDurumu.OturumAcilmis
                                    ? Text(
                                        "  Toplam Tutar: " +
                                            (state as TodayOrdersDetayLoadedState)
                                                .orders[0]
                                                .toplam
                                                .toStringAsFixed(2) +
                                            (state as TodayOrdersDetayLoadedState)
                                                .orders[0]
                                                .typeOfMoney,
                                        style: TextStyle(fontSize: 25),
                                      )
                                    : Text(""),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<void> _showMyDialog(int value, int sidsno) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uyarı'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Bugün listesinden çıkarmak istediğinize emin misiniz?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  geriDon = true;
                  PostPlanToday(value, sidsno);

                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Bugün Listesinden Çıkarıldı"),
                    duration: Duration(seconds: 2),
                  ));
                },
                child: Text("Evet")),
            TextButton(
              child: const Text('Vazgeç'),
              onPressed: () {
                geriDon = false;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<http.Response> PostPlanToday(int title, int sidsno) {
    String _username = 'admin';
    String _password = "hV5d}'G8Hr7_WSQ]";
    String _basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));

    var url2 = Uri.parse("http://193.149.3.37/set_plantoday/");

    var result = http.post(url2,
        headers: {'authorization': _basicAuth},
        body: {'sidsno_id': sidsno.toString(), 'value': title.toString()});

    /* return http.post(
      Uri.parse('http://193.149.3.37/set_plantoday'),
      headers: <String, String>{
        'authorization': _basicAuth,
      },
      body: jsonEncode(<String, int>{
        'value': title,
        'sidsno_id': sidsno,
      }),
    ); */
  }
}
