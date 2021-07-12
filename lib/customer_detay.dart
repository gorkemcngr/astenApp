import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/costumersdetay/customers_detay_bloc.dart';

import 'package:turkish/turkish.dart' as turk;

class CustomerDetay extends StatefulWidget {
  final String sidnum;

  CustomerDetay({this.sidnum});

  @override
  _CustomerDetayState createState() => _CustomerDetayState();
}

class _CustomerDetayState extends State<CustomerDetay> {
  int toplam = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _customersDetayBloc = BlocProvider.of<CustomersDetayBloc>(context);
    _customersDetayBloc.add(FetchCustomersDetayEvent(firkod: widget.sidnum));
<<<<<<< HEAD
=======

    print("test işlemi");
>>>>>>> da380f049d5fc7b8a8f770711d720d6c9fa1919a
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Container AppBody(BuildContext context) {
    final _customersDetayBloc = BlocProvider.of<CustomersDetayBloc>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: BlocBuilder(
        bloc: _customersDetayBloc,
        builder: (context, CustomersDetayState state) {
          if (state is CustomersDetayLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CustomersDetayLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Firma Adı : ',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: (state as CustomersDetayLoadedState)
                              .customers[0]
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
                      text: 'Firma Kodu : ',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: (state as CustomersDetayLoadedState)
                              .customers[0]
                              .firkod,
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
                      text: 'Vergi Dairesi : ',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: (state as CustomersDetayLoadedState)
                              .customers[0]
                              .firvda
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
                      text: 'Vergi No : ',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: (state as CustomersDetayLoadedState)
                              .customers[0]
                              .firvno
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
                      text: 'Firma mail : ',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: (state as CustomersDetayLoadedState)
                              .customers[0]
                              .fireml
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Adresler",
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
                              itemCount: (state as CustomersDetayLoadedState)
                                  .customers
                                  .length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shadowColor: Colors.blue,
                                  elevation: 4,
                                  child: ListTile(
                                    title: Text(
                                      (state as CustomersDetayLoadedState)
                                              .customers[index]
                                              .adresCount
                                              .toString() +
                                          ". Adres",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                          height: 0.7,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Telefon numarası : ',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: (state
                                                          as CustomersDetayLoadedState)
                                                      .customers[index]
                                                      .adrtl1
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
                                              text: 'Adres : ',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: (state
                                                          as CustomersDetayLoadedState)
                                                      .customers[index]
                                                      .adradr
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
                                    /* Text(
                                              "adrtip : ${(state as CustomersDetayLoadedState).customers[index].adrtip} \nTelefon numarası : ${((state as CustomersDetayLoadedState).customers[index].adrtl1).toString()} \nAdres : ${((state as CustomersDetayLoadedState).customers[index].adradr)}",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ) */
                                    ,
                                  ),
                                );
                              }),
                        ),
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

  Widget AppBodyLandScape(BuildContext context) {
    final _customersDetayBloc = BlocProvider.of<CustomersDetayBloc>(context);
    return BlocBuilder(
      bloc: _customersDetayBloc,
      builder: (context, CustomersDetayState state) {
        if (state is CustomersDetayLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CustomersDetayLoadedState) {
          return Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 2.2,
                margin: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Firma Adı : ',
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: (state as CustomersDetayLoadedState)
                                  .customers[0]
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
                          text: 'Firma Kodu : ',
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: (state as CustomersDetayLoadedState)
                                  .customers[0]
                                  .firkod,
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
                          text: 'Vergi Dairesi : ',
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: (state as CustomersDetayLoadedState)
                                  .customers[0]
                                  .firvda
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
                          text: 'Vergi No : ',
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: (state as CustomersDetayLoadedState)
                                  .customers[0]
                                  .firvno
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
                          text: 'Firma mail : ',
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: (state as CustomersDetayLoadedState)
                                  .customers[0]
                                  .fireml
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ]),
                    ),
                    Divider(
                      height: 0.5,
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
                          "Adresler",
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
                                          (state as CustomersDetayLoadedState)
                                              .customers
                                              .length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          shadowColor: Colors.blue,
                                          elevation: 4,
                                          child: ListTile(
                                            title: Text(
                                              (state as CustomersDetayLoadedState)
                                                      .customers[index]
                                                      .adresCount
                                                      .toString() +
                                                  ". Adres",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Divider(
                                                  height: 0.7,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                      text:
                                                          'Telefon numarası : ',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: (state
                                                                  as CustomersDetayLoadedState)
                                                              .customers[index]
                                                              .adrtl1
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
                                                      text: 'Adres : ',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: (state
                                                                  as CustomersDetayLoadedState)
                                                              .customers[index]
                                                              .adradr
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
                                            /* Text(
                                              "adrtip : ${(state as CustomersDetayLoadedState).customers[index].adrtip} \nTelefon numarası : ${((state as CustomersDetayLoadedState).customers[index].adrtl1).toString()} \nAdres : ${((state as CustomersDetayLoadedState).customers[index].adradr)}",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ) */
                                            ,
                                          ),
                                        );
                                      }),
                                ),
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
<<<<<<< HEAD
          return Container();
=======
          return null;
>>>>>>> da380f049d5fc7b8a8f770711d720d6c9fa1919a
        }
      },
    );
  }
}
