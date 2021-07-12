import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'package:flutter_asten_app/models/deliveriesM.dart';
import 'package:flutter_asten_app/product_detay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'auth_service.dart';
import 'blocs/deliveriesdetay/deliveries_detay_bloc.dart';
import 'blocs/productDetay/products_detay_bloc.dart';

class DeliveriesDetay extends StatefulWidget {
  int sednum;

  DeliveriesDetay({this.sednum});

  @override
  _DeliveriesDetayState createState() => _DeliveriesDetayState();
}

class _DeliveriesDetayState extends State<DeliveriesDetay> {
  List<DeliveriesM> deliveries;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _deliveriesDetayBloc = BlocProvider.of<DeliveriesDetayBloc>(context);
    _deliveriesDetayBloc.add(FetchDeliveriesDetayEvent(sednum: widget.sednum));
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
    final _deliveriesDetayBloc = BlocProvider.of<DeliveriesDetayBloc>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: BlocBuilder(
        bloc: _deliveriesDetayBloc,
        builder: (context, DeliveriesDetayState state) {
          if (state is DeliveriesDetayLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DeliveriesDetayLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (state as DeliveriesDetayLoadedState)
                          .deliveries[0]
                          .sednum
                          .toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (state as DeliveriesDetayLoadedState).deliveries[0].tarih,
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
                          text: (state as DeliveriesDetayLoadedState)
                              .deliveries[0]
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
                      text: 'Kargo: ',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: (state as DeliveriesDetayLoadedState)
                              .deliveries[0]
                              .kargo
                              .toString(),
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
                      text: 'İrsaliye No: ',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: (state as DeliveriesDetayLoadedState)
                              .deliveries[0]
                              .irsaliyeNo
                              .toString(),
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
                      text: 'Sevkiyat Adresi: ',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: (state as DeliveriesDetayLoadedState)
                              .deliveries[0]
                              .sevtad
                              .toString(),
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
                      text: 'Yetkili: ',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: (state as DeliveriesDetayLoadedState)
                              .deliveries[0]
                              .sipmyt
                              .toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ]),
                ),
                Divider(
                  height: 10,
                ),
                (state as DeliveriesDetayLoadedState)
                            .deliveries[0]
                            .faturaflag ==
                        1
                    ? Row(
                        children: [
                          Text("Fatura kesilmiştir ✅",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 20,
                          ),
                          myAuth.durum == KullaniciDurumu.OturumAcilmis
                              ? TextButton(
                                  onPressed: () async => {
                                        await launch((state
                                                as DeliveriesDetayLoadedState)
                                            .deliveries[0]
                                            .faturaurl)
                                      },
                                  child: Text(
                                    "Faturayı Görüntüle",
                                    style: TextStyle(fontSize: 16),
                                  ))
                              : Container(),
                        ],
                      )
                    : Container(),
                Divider(
                  height: 0.5,
                ),
                SizedBox(
                  height: 20,
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
                              itemCount: (state as DeliveriesDetayLoadedState)
                                  .deliveries
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
                                                          .deliveries[index]
                                                          .sidtj,
                                                    ),
                                                  )));
                                    },
                                    title: Text(
                                        (state as DeliveriesDetayLoadedState)
                                            .deliveries[index]
                                            .stkadi
                                            .toString()),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                          height: 0.7,
                                        ),
                                        myAuth.durum ==
                                                KullaniciDurumu.OturumAcilmis
                                            ? RichText(
                                                text: TextSpan(
                                                    text: 'Vade  : ',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: (state
                                                                as DeliveriesDetayLoadedState)
                                                            .deliveries[index]
                                                            .stpadi
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
                                                      ((state as DeliveriesDetayLoadedState)
                                                              .deliveries[index]
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
                                        RichText(
                                          text: TextSpan(
                                              text: 'Sevkiyat Miktarı  : ',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      ((state as DeliveriesDetayLoadedState)
                                                              .deliveries[index]
                                                              .sedmik)
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
                                        RichText(
                                          text: TextSpan(
                                              text: 'Kalan Miktar  : ',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: (((state as DeliveriesDetayLoadedState)
                                                              .deliveries[index]
                                                              .sedmik) -
                                                          ((state as DeliveriesDetayLoadedState)
                                                              .deliveries[index]
                                                              .sedmik))
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
                                        RichText(
                                          text: TextSpan(
                                              text: 'Not  : ',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: (state
                                                          as DeliveriesDetayLoadedState)
                                                      .deliveries[index]
                                                      .sidozl
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    )

                                    /*Text(
                                      "stpadi : ${(state as DeliveriesDetayLoadedState).deliveries[index].stpadi} \nSipariş Miktarı : ${(state as DeliveriesDetayLoadedState).deliveries[index].stpadi} \nsedmik : ${(state as DeliveriesDetayLoadedState).deliveries[index].sedmik} \nsidozl : ${(state as DeliveriesDetayLoadedState).deliveries[index].sidozl.toString()} \nsippbr : ${(state as DeliveriesDetayLoadedState).deliveries[index].sidpbr} \nstkadi : ${(state as DeliveriesDetayLoadedState).deliveries[index].stkadi} \nsidufy : ${(state as DeliveriesDetayLoadedState).deliveries[index].sidufy}",
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
                                    (state as DeliveriesDetayLoadedState)
                                        .deliveries[0]
                                        .toplam
                                        .toStringAsFixed(2) +
                                    (state as DeliveriesDetayLoadedState)
                                        .deliveries[0]
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
<<<<<<< HEAD
            return Container();
=======
            return null;
>>>>>>> da380f049d5fc7b8a8f770711d720d6c9fa1919a
          }
        },
      ),
    );
  }

  Container AppBodyLandScape(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final _deliveriesDetayBloc = BlocProvider.of<DeliveriesDetayBloc>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: BlocBuilder(
        bloc: _deliveriesDetayBloc,
        builder: (context, DeliveriesDetayState state) {
          if (state is DeliveriesDetayLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DeliveriesDetayLoadedState) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width / 2,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (state as DeliveriesDetayLoadedState)
                                  .deliveries[0]
                                  .sednum
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (state as DeliveriesDetayLoadedState)
                                  .deliveries[0]
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
                                  text: (state as DeliveriesDetayLoadedState)
                                      .deliveries[0]
                                      .firadi,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]),
                        ),

                        Divider(
                          height: 0.5,
                        ),

                        RichText(
                          text: TextSpan(
                              text: 'Kargo: ',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text: (state as DeliveriesDetayLoadedState)
                                      .deliveries[0]
                                      .kargo
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]),
                        ),
                        Divider(
                          height: 0.5,
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'İrsaliye No: ',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text: (state as DeliveriesDetayLoadedState)
                                      .deliveries[0]
                                      .irsaliyeNo
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]),
                        ),
                        Divider(
                          height: 0.5,
                        ),

                        RichText(
                          text: TextSpan(
                              text: 'Sevkiyat Adresi: ',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text: (state as DeliveriesDetayLoadedState)
                                      .deliveries[0]
                                      .sevtad,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]),
                        ),
                        Divider(
                          height: 0.5,
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Yetkili: ',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text: (state as DeliveriesDetayLoadedState)
                                      .deliveries[0]
                                      .sipmyt,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]),
                        ),
                        Divider(
                          height: 0.5,
                        ),
                        (state as DeliveriesDetayLoadedState)
                                    .deliveries[0]
                                    .faturaflag ==
                                1
                            ? Row(
                                children: [
                                  Text("Fatura kesilmiştir ✅",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  myAuth.durum == KullaniciDurumu.OturumAcilmis
                                      ? TextButton(
                                          onPressed: () async => {
                                                await launch((state
                                                        as DeliveriesDetayLoadedState)
                                                    .deliveries[0]
                                                    .faturaurl)
                                              },
                                          child: Text(
                                            "Faturayı Görüntüle",
                                            style: TextStyle(fontSize: 16),
                                          ))
                                      : Container(),
                                ],
                              )
                            : Container(),
                        RichText(
                          text: TextSpan(
                              text: 'stpadi : ',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text: (state as DeliveriesDetayLoadedState)
                                      .deliveries[0]
                                      .stpadi,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]),
                        ),
                        Divider(
                          height: 10,
                        ),
                        Text(
                            (state as DeliveriesDetayLoadedState)
                                        .deliveries[0]
                                        .faturaflag ==
                                    1
                                ? "Fatura kesilmiştir ✅"
                                : "",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Divider(
                          height: 0.5,
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        ///////////////////////////////////////////////////////////////////////////////////////////////////////
                      ],
                    ),
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
                                          (state as DeliveriesDetayLoadedState)
                                              .deliveries
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
                                                                  .deliveries[
                                                                      index]
                                                                  .sidtj,
                                                            ),
                                                          )));
                                            },
                                            title: Text((state
                                                    as DeliveriesDetayLoadedState)
                                                .deliveries[index]
                                                .stkadi
                                                .toString()),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Divider(
                                                  height: 0.7,
                                                ),
                                                myAuth.durum ==
                                                        KullaniciDurumu
                                                            .OturumAcilmis
                                                    ? RichText(
                                                        text: TextSpan(
                                                            text: 'Vade  : ',
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
                                                                        as DeliveriesDetayLoadedState)
                                                                    .deliveries[
                                                                        index]
                                                                    .stpadi
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
                                                                      as DeliveriesDetayLoadedState)
                                                                  .deliveries[
                                                                      index]
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
                                                RichText(
                                                  text: TextSpan(
                                                      text:
                                                          'Sevkiyat Miktarı  : ',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: ((state
                                                                      as DeliveriesDetayLoadedState)
                                                                  .deliveries[
                                                                      index]
                                                                  .sedmik)
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
                                                RichText(
                                                  text: TextSpan(
                                                      text: 'Kalan Miktar  : ',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: (((state as DeliveriesDetayLoadedState)
                                                                      .deliveries[
                                                                          index]
                                                                      .sedmik) -
                                                                  ((state as DeliveriesDetayLoadedState)
                                                                      .deliveries[
                                                                          index]
                                                                      .sedmik))
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
                                                RichText(
                                                  text: TextSpan(
                                                      text: 'Not  : ',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: (state
                                                                  as DeliveriesDetayLoadedState)
                                                              .deliveries[index]
                                                              .sidozl
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ]),
                                                ),
                                              ],
                                            )

                                            /*Text(
                                      "stpadi : ${(state as DeliveriesDetayLoadedState).deliveries[index].stpadi} \nSipariş Miktarı : ${(state as DeliveriesDetayLoadedState).deliveries[index].stpadi} \nsedmik : ${(state as DeliveriesDetayLoadedState).deliveries[index].sedmik} \nsidozl : ${(state as DeliveriesDetayLoadedState).deliveries[index].sidozl.toString()} \nsippbr : ${(state as DeliveriesDetayLoadedState).deliveries[index].sidpbr} \nstkadi : ${(state as DeliveriesDetayLoadedState).deliveries[index].stkadi} \nsidufy : ${(state as DeliveriesDetayLoadedState).deliveries[index].sidufy}",
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
                                            (state as DeliveriesDetayLoadedState)
                                                .deliveries[0]
                                                .toplam
                                                .toStringAsFixed(2) +
                                            (state as DeliveriesDetayLoadedState)
                                                .deliveries[0]
                                                .typeOfMoney,
                                        style: TextStyle(fontSize: 25),
                                      )
                                    : Text(""),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
<<<<<<< HEAD
            return Container();
=======
            return null;
>>>>>>> da380f049d5fc7b8a8f770711d720d6c9fa1919a
          }
        },
      ),
    );
  }
}
