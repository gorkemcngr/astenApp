import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asten_app/blocs/deliveries/deliveries_bloc.dart';
import 'package:flutter_asten_app/blocs/orders/orders_bloc.dart';
import 'package:flutter_asten_app/deliveries_detay.dart';
import 'package:flutter_asten_app/models/order_list.dart';
import 'package:flutter_asten_app/product_list.dart';
import 'package:flutter_asten_app/today_order_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'customer_list.dart';
import 'deliveries_listesi.dart';
import 'kullanici_giris.dart';
import 'models/deliveriesM.dart';
import 'models/delivery_list.dart';
import 'order_detay.dart';
import 'package:turkish/turkish.dart' as turk;
import 'package:http/http.dart' as http;
import 'dart:math' as mat;

import 'orders_listesi.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  bool _loadingproducts = false;
  ScrollController _scrollController = ScrollController();

  //
  bool _loadingdeliveries = true;
  ScrollController _scrollController2 = ScrollController();

  //
  List<OrderList> orders;
  static int orderPage = 0;
  static int orderPage2 = 0;
  static int deliveryPage = 0;
  static int deliveryPage2 = 0;
  bool orderArama = false;
  bool deliveryArama = false;

  List<DeliveryList> deliveries;
  TabController tabController;
  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  var arananSiparis;
  var arananSevkiyat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 5, vsync: this);

    deliveries = [];
    orders = [];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    print("build çalıştı");
    /* switch (myAuth.durum) {
      case KullaniciDurumu.OturumAciliyor:
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      case KullaniciDurumu.OturumAcilmis: */
    return Scaffold(
        appBar: AppBar(
          actions: [
            myAuth.durum == KullaniciDurumu.OturumAcilmis
                ? IconButton(
                    icon: Icon(
                      Icons.logout,
                      size: 32,
                    ),
                    onPressed: () async {
                      await myAuth.signOut();
                    })
                : IconButton(
                    icon: Icon(
                      Icons.login,
                      size: 32,
                    ),
                    onPressed: () {
                      GirisYapDialog(context, myAuth);
                    })
          ],
          bottom: tabBarim(),
          title: Text(
            "ASTENCUBE ❒",
            style: TextStyle(
                fontSize: 35,
                fontStyle: FontStyle.italic,
                fontFamily: "Roboto-Regular"),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: TabBarView(controller: tabController, children: [
          Orders(),
          Deliveries(),
          Customers(),
          Products(),
          TodayOrders(),
        ]));
    /*
      case KullaniciDurumu.OturumAcilmamis:
        return KullaniciGiris();
    } */
  }

  ///////////////////////////////////////

  _getDeliveries(int index) async {
    List<DeliveryList> sipler = [];
    if (mounted) {
      setState(() {
        _loadingdeliveries = true;
      });
    }
    var url2 = Uri.parse("http://45.139.220.15:3200/deliverylist/$index");
    final response = await http.get(url2);
    List decodedJson = json.decode(response.body);
    for (int i = 0; i < decodedJson.length; i++) {
      sipler.add(DeliveryList.fromJson(decodedJson[i]));
    }

    if (mounted) {
      setState(() {
        _loadingdeliveries = false;
        deliveries.addAll(sipler);
        deliveryPage++;
      });
    }
  }

  _getMoreDeliveries(int index) async {
    List<DeliveryList> sevkiyatlar = [];

    var url2 = Uri.parse("http://45.139.220.15:3200/deliverylist/$index");
    final response = await http.get(url2);
    List decodedJson = json.decode(response.body);
    for (int i = 0; i < decodedJson.length; i++) {
      sevkiyatlar.add(DeliveryList.fromJson(decodedJson[i]));
    }
    if (mounted) {
      setState(() {
        _loadingproducts = false;
        deliveries.addAll(sevkiyatlar);
        orderPage++;
      });
    }
  }

  void GirisYapDialog(BuildContext context, myAuth) {
    var _formKey2 = GlobalKey<FormState>();
    String user_email;
    String user_password;

    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              Form(
                key: _formKey2,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close))),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Giriş Yap",
                        style: TextStyle(fontSize: 26),
                      ),
                      margin: EdgeInsets.only(left: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          user_email = value;
                        },
                        validator: (value) {
                          return validateEmail(value);
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email Giriniz',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onSaved: (value) {
                          user_password = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Şifre',
                            hintText: 'Şifrenizi Giriniz',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    myAuth.oturum == OturumAcma.yanlisPassword
                        ? Text("Yanlış kullanıcı adı veya şifre",
                            style: TextStyle(color: Colors.red))
                        : SizedBox(),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey2.currentState.validate()) {
                            _formKey2.currentState.save();
                            await myAuth.signInUserWithEmailandPassword(
                                user_email, user_password);
                            if (await myAuth.oturum ==
                                OturumAcma.yanlisPassword) {
                              _showMyDialog();
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Giriş Başarılı"),
                                duration: Duration(seconds: 2),
                              ));
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Text("Giriş Yap"))
                  ],
                ),
              ),
            ],
          );
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hata'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Yanlış kullanıcı Adı Ya da Şifre'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Geri Dön'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? "Lütfen Geçerli Bir email giriniz" : null;
  }

/*
  void orderAramaYapJson(var arananSiparis) async {
    orderArama = true;
    if (arananSiparis is String) {
      List<OrderList> sipler = [];

      var url2 =
          Uri.parse("http://45.139.220.15:3200/search/orders/$arananSiparis");
      final response = await http.get(url2);
      List decodedJson = json.decode(response.body);
      print(decodedJson.toString());
      for (int i = 0; i < decodedJson.length; i++) {
        sipler.add(OrderList.fromJson(decodedJson[i]));
        listeElemanDuzenle();
      }

      orders.clear();
      orders.addAll(sipler);
    } else if (arananSiparis is int) {
      List<OrderList> sipler = [];

      var url2 =
          Uri.parse("http://45.139.220.15:3200/search/orders/$arananSiparis");
      final response = await http.get(url2);
      List decodedJson = json.decode(response.body);
      for (int i = 0; i < decodedJson.length; i++) {
        sipler.add(OrderList.fromJson(decodedJson[i]));
        listeElemanDuzenle();
      }

      orders.clear();
      orders.addAll(sipler);
    }

    setState(() {});
  } */
/*
  void DeliveryAramaYapJson(var arananSiparis) async {
    deliveryArama = true;
    if (arananSiparis is String) {
      List<DeliveryList> sevkiyatlar = [];

      var url2 = Uri.parse(
          "http://45.139.220.15:3200/search/deliveries/$arananSiparis");
      final response = await http.get(url2);
      List decodedJson = json.decode(response.body);

      for (int i = 0; i < decodedJson.length; i++) {
        sevkiyatlar.add(DeliveryList.fromJson(decodedJson[i]));
        listeElemanDuzenle2();
      }

      deliveries.clear();
      deliveries.addAll(sevkiyatlar);
    } else if (arananSiparis is int) {
      List<DeliveryList> sevkiyatlar = [];

      var url2 = Uri.parse(
          "http://45.139.220.15:3200/search/deliveries/$arananSiparis");
      final response = await http.get(url2);
      List decodedJson = json.decode(response.body);
      for (int i = 0; i < decodedJson.length; i++) {
        sevkiyatlar.add(DeliveryList.fromJson(decodedJson[i]));
        listeElemanDuzenle2();
      }

      deliveries.clear();
      deliveries.addAll(sevkiyatlar);
    }

    setState(() {});
  } */
/*
  listeElemanDuzenle() async {
    List<OrderList> yeniSiparisler = [];
    yeniSiparisler = await orders;
    for (int i = 1; i < yeniSiparisler.length; i++) {
      if (yeniSiparisler[i].sidnum == yeniSiparisler[i - 1].sidnum) {
        yeniSiparisler.removeAt(i);
      } else {}
    }
    return yeniSiparisler;
  }

  listeElemanDuzenle2() async {
    List<DeliveryList> yeniSevkiyatlar = [];
    yeniSevkiyatlar = await deliveries;
    for (int i = 1; i < yeniSevkiyatlar.length; i++) {
      if (yeniSevkiyatlar[i].sednum == yeniSevkiyatlar[i - 1].sednum) {
        yeniSevkiyatlar.removeAt(i);
      } else {}
    }
    return yeniSevkiyatlar;
  }

  String tarihDonustur(String tarih) {
    var arr = tarih.split(' ');
    String tarih1 = arr[0];
    var arr1 = tarih1.split('-');
    String tarihSonHal = arr1[2] + "/" + arr1[1] + "/" + arr1[0];
    return tarihSonHal;
  } */

  TabBar tabBarim() {
    return TabBar(
        indicatorColor: Colors.orange,
        controller: tabController,
        tabs: [
          Container(
            child: Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //  Icon(Icons.update),
                  Text(
                    "Sip.",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Icon(Icons.directions_car),

                  Text(
                    "Sevk.",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //   Icon(Icons.person),
                  Text(
                    "Müşt.",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //  Icon(Icons.person),
                  Text(
                    "Ürün",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //  Icon(Icons.person),
                  Text(
                    "Bugün",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}
