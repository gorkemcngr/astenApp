import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asten_app/deliveries_detay.dart';
import 'package:flutter_asten_app/models/orders.dart';
import 'models/deliveries.dart';
import 'order_detay.dart';
import 'package:turkish/turkish.dart' as turk;
import 'dart:math' as mat;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _loadingproducts = true;
  int _perPage = 20;
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreProducts = false;
  bool _moreProductsAvailable = true;

  //
  bool _loadingdeliveries = true;
  int _perPage2 = 20;
  DocumentSnapshot _lastDocument2;
  ScrollController _scrollController2 = ScrollController();
  bool _gettingMoreDeliveries = false;
  bool _moreDeliveriesAvailable = true;

  //
  List<Orders> siparisler;
  List<Deliveries> deliveries;
  TabController tabController;
  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  var arananSiparis;
  var arananSevkiyat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _getProducts();
    _getDeliveries();
    siparisler = [];
    deliveries = [];

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if (maxScroll - currentScroll <= delta) {
        _getMoreProduct();
      }
    });

    //
    _scrollController2.addListener(() {
      double maxScroll2 = _scrollController2.position.maxScrollExtent;
      double currentScroll2 = _scrollController2.position.pixels;
      double delta2 = MediaQuery.of(context).size.height * 0.25;

      if (maxScroll2 - currentScroll2 <= delta2) {
        _getMoreDeliveries();
      }
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: tabBarim(),
          title: Text(
            "asten",
            style: TextStyle(fontSize: 35, fontStyle: FontStyle.italic),
          ),
        ),
        body: TabBarView(controller: tabController, children: [
          _loadingproducts == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ordersPage(context),
          _loadingdeliveries == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : DeliveriesPage(context),
        ]));
  }

  Column DeliveriesPage(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Form(
                  key: formKey2,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.length == 0) {
                        deliveries.clear();
                        _getDeliveries();
                      }
                    },
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        labelText: "Firma adını veya Sevkiyat No. giriniz",
                        hintText: "Firma Adı/Sevkiyat No.",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: BorderRadius.circular(25)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onSaved: (value) {
                      try {
                        arananSevkiyat = int.parse(value);
                      } catch (e) {
                        arananSevkiyat = value;
                      }
                    },
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey2.currentState.validate()) {
                      formKey2.currentState.save();

                      DeliveriesAramaYap(arananSevkiyat);
                    } else {
                      deliveries.clear();
                      _getDeliveries();
                    }
                  },
                  child: Text(
                    "Ara",
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ),
        Expanded(
          child: Container(
              child: deliveries.length == 0
                  ? Center(
                      child: Text("No Products to show"),
                    )
                  : ListView.builder(
                      controller: _scrollController2,
                      itemCount: deliveries.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DeliveriesDetay(
                                            deliveries: deliveries[index],
                                          )));
                            },
                            title: Text(deliveries[index].firadi),
                            subtitle: Text(deliveries[index].tarih),
                          ),
                        );
                      })),
        ),
      ],
    );
  }

  Column ordersPage(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.length == 0) {
                        siparisler.clear();
                        _getProducts();
                      }
                    },
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
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
                      try {
                        arananSiparis = int.parse(value);
                      } catch (e) {
                        arananSiparis = value;
                      }
                    },
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();

                      orderAramaYap(arananSiparis);
                    } else {
                      siparisler.clear();
                      _getProducts();
                    }
                  },
                  child: Text(
                    "Ara",
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ),
        Expanded(
          child: Container(
              child: siparisler.length == 0
                  ? Center(
                      child: Text("No Products to show"),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: siparisler.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetay(
                                            order: siparisler[index],
                                          )));
                            },
                            title: Text(siparisler[index].firadi),
                            subtitle: Text(siparisler[index].tarih),
                          ),
                        );
                      })),
        ),
      ],
    );
  }

  _getMoreProduct() async {
    print("_getMoreProducts called");

    if (_moreProductsAvailable == false) {
      print("No More Products");
      return;
    }
    if (_gettingMoreProducts == true) {
      return;
    }

    _gettingMoreProducts = true;

    Query q = _firestore
        .collection("orders")
        .orderBy("epoch", descending: true)
        .startAfter([_lastDocument.data()["epoch"]]).limit(_perPage);

    QuerySnapshot querySnapshot = await q.get();

    if (querySnapshot.docs.length < _perPage) {
      _moreProductsAvailable = false;
    }
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    for (var dokuman in querySnapshot.docs) {
      addSiparisler(dokuman);
    }
    setState(() {});
    _gettingMoreProducts = false;
  }

  _getProducts() async {
    Query q = _firestore
        .collection("orders")
        .orderBy("epoch", descending: true)
        .limit(_perPage);
    if (mounted) {
      setState(() {
        _loadingproducts = true;
      });
    }
    QuerySnapshot querySnapshot = await q.get();

    for (var dokuman in querySnapshot.docs) {
      addSiparisler(dokuman);
    }

    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    if (mounted) {
      setState(() {
        _loadingproducts = false;
      });
    }
  }

  _getDeliveries() async {
    Query q = _firestore
        .collection("deliveries")
        .orderBy("epoch", descending: true)
        .limit(_perPage2);
    if (mounted) {
      setState(() {
        _loadingdeliveries = true;
      });
    }
    QuerySnapshot querySnapshot = await q.get();

    for (var dokuman in querySnapshot.docs) {
      addDeliveries(dokuman);
    }

    _lastDocument2 = querySnapshot.docs[querySnapshot.docs.length - 1];
    if (mounted) {
      setState(() {
        _loadingdeliveries = false;
      });
    }
  }

  _getMoreDeliveries() async {
    print("_getMoreDeliveries called");

    if (_moreDeliveriesAvailable == false) {
      print("No More Deliveries");
      return;
    }
    if (_gettingMoreDeliveries == true) {
      return;
    }

    _gettingMoreDeliveries = true;

    Query q = _firestore
        .collection("deliveries")
        .orderBy("epoch", descending: true)
        .startAfter([_lastDocument2.data()["epoch"]]).limit(_perPage2);

    QuerySnapshot querySnapshot = await q.get();

    if (querySnapshot.docs.length < _perPage2) {
      _moreDeliveriesAvailable = false;
    }
    _lastDocument2 = querySnapshot.docs[querySnapshot.docs.length - 1];
    for (var dokuman in querySnapshot.docs) {
      addDeliveries(dokuman);
    }

    setState(() {});
    _gettingMoreDeliveries = false;
  }

  void orderAramaYap(var arananSiparis) async {
    if (arananSiparis is String) {
      arananSiparis = turk.turkish.toUpperCase(arananSiparis);
      var stringSorgula = await _firestore
          .collection("orders")
          .orderBy("firadi")
          .startAt([arananSiparis]).endAt([arananSiparis + "\uf8ff"]).get();

      siparisler.clear();

      for (var dokuman in stringSorgula.docs) {
        addSiparisler(dokuman);
      }
    } else if (arananSiparis is int) {
      Query q = _firestore.collection("orders").orderBy("firadi");
      QuerySnapshot querySnapshot = await q.get();

      var stringSorgula = await _firestore
          .collection("orders")
          .where('sipnum', isEqualTo: arananSiparis)
          .get();

      siparisler.clear();
      for (var dokuman in stringSorgula.docs) {
        addSiparisler(dokuman);
      }
    }

    setState(() {});
  }

  void addDeliveries(QueryDocumentSnapshot dokuman) {
    deliveries.add(Deliveries(
        dokuman.data()["firadi"],
        dokuman.data()["firkod"],
        dokuman.data()["sednum"],
        dokuman.data()["sevirs"],
        dokuman.data()["sevitr"],
        dokuman.data()["sevtad"],
        dokuman.data()["sipmyt"],
        dokuman.data()["stpadi"],
        tarihDonustur(dokuman.data()["tarih"]),
        DDetay.fromMap(dokuman.data()["detay"])));
  }

  void addSiparisler(QueryDocumentSnapshot dokuman) {
    siparisler.add(Orders(
        dokuman.data()["firadi"],
        dokuman.data()["firkod"],
        dokuman.data()["sipnum"],
        tarihDonustur(dokuman.data()["tarih"]),
        Detay.fromMap(dokuman.data()["detay"])));
  }

  void DeliveriesAramaYap(var arananSevkiyat) async {
    if (arananSevkiyat is String) {
      Query q = _firestore.collection("deliveries").orderBy("firadi");
      QuerySnapshot querySnapshot = await q.get();
      arananSevkiyat = turk.turkish.toUpperCase(arananSevkiyat);
      var stringSorgula = await _firestore
          .collection("deliveries")
          .orderBy("firadi")
          .startAt([arananSevkiyat]).endAt([arananSevkiyat + "\uf8ff"]).get();
      deliveries.clear();
      for (var dokuman in stringSorgula.docs) {
        addDeliveries(dokuman);
      }
    } else if (arananSevkiyat is int) {
      Query q = _firestore.collection("deliveries").orderBy("firadi");
      QuerySnapshot querySnapshot = await q.get();

      var stringSorgula = await _firestore
          .collection("deliveries")
          .where('sednum', isEqualTo: arananSevkiyat)
          .get();

      deliveries.clear();
      for (var dokuman in stringSorgula.docs) {
        addDeliveries(dokuman);
      }
    }

    setState(() {});
  }

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
                  Icon(Icons.update),
                  Text(
                    "Siparişler",
                    style: TextStyle(fontSize: 20),
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
                  Icon(Icons.directions_car),
                  Text(
                    "Sevkiyatlar",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ]);
  }

  String tarihDonustur(String tarih) {
    var arr = tarih.split(' ');
    String tarih1 = arr[0];
    var arr1 = tarih1.split('-');
    String tarihSonHal = arr1[2] + "/" + arr1[1] + "/" + arr1[0];
    return tarihSonHal;
  }
}

/*



 */
