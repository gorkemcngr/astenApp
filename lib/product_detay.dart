import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:turkish/turkish.dart' as turk;

import 'blocs/productDetay/products_detay_bloc.dart';

class ProductDetay extends StatefulWidget {
  final String stkkod;

  ProductDetay({this.stkkod});

  @override
  _ProductDetayState createState() => _ProductDetayState();
}

class _ProductDetayState extends State<ProductDetay> {
  int toplam = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _productsDetayBloc = BlocProvider.of<ProductsDetayBloc>(context);
    _productsDetayBloc.add(FetchProductsDetayEvent(stkkod: widget.stkkod));
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
    final _productsDetayBloc = BlocProvider.of<ProductsDetayBloc>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: BlocBuilder(
        bloc: _productsDetayBloc,
        builder: (context, ProductsDetayState state) {
          if (state is ProductsDetayLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductsDetayLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    (state as ProductsDetayLoadedState).products[0].stkadi,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Teknik Özellikler",
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
                              itemCount: (state as ProductsDetayLoadedState)
                                  .products
                                  .length,
                              itemBuilder: (context, index) {
                                return Wrap(
                                  direction: Axis.horizontal,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: RichText(
                                        text: TextSpan(
                                            text:
                                                (state as ProductsDetayLoadedState)
                                                        .products[index]
                                                        .tozadi +
                                                    " :",
                                            style: TextStyle(
                                                fontSize: 19,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: (state
                                                        as ProductsDetayLoadedState)
                                                    .products[index]
                                                    .tozdeg,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    Divider(
                                      height: 0.5,
                                    )
                                  ],
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
            return CircularProgressIndicator();
>>>>>>> da380f049d5fc7b8a8f770711d720d6c9fa1919a
          }
        },
      ),
    );
  }

  Widget AppBodyLandScape(BuildContext context) {
    final _customersDetayBloc = BlocProvider.of<ProductsDetayBloc>(context);
    return BlocBuilder(
      bloc: _customersDetayBloc,
      builder: (context, ProductsDetayState state) {
        if (state is ProductsDetayLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductsDetayLoadedState) {
          return Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 2.2,
                margin: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        (state as ProductsDetayLoadedState).products[0].stkadi,
                        style: TextStyle(fontSize: 25),
                      ),
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
                          "Teknik Özellikler",
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
                                          (state as ProductsDetayLoadedState)
                                              .products
                                              .length,
                                      itemBuilder: (context, index) {
                                        return Wrap(
                                          direction: Axis.horizontal,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              child: RichText(
                                                text: TextSpan(
                                                    text:
                                                        (state as ProductsDetayLoadedState)
                                                                .products[index]
                                                                .tozadi +
                                                            " :",
                                                    style: TextStyle(
                                                        fontSize: 19,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: (state
                                                                as ProductsDetayLoadedState)
                                                            .products[index]
                                                            .tozdeg,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                            Divider(
                                              height: 0.5,
                                            )
                                          ],
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
