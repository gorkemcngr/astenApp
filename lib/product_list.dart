import 'package:flutter/material.dart';
import 'package:flutter_asten_app/blocs/products/products_bloc.dart';

import 'package:flutter_asten_app/order_detay.dart';
import 'package:flutter_asten_app/product_detay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/productDetay/products_detay_bloc.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
    final _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _productsBloc.add(FetchProductsEvent(page: orderPage2));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        orderPage2++;
        if (orderArama == false) {
          _productsBloc.add(FetchMoreProductsEvent(page: orderPage2));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _productsBloc = BlocProvider.of<ProductsBloc>(context);

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
                      if (value.length == 0) {
                        orderArama = false;
                        orderPage2 = 0;
                        BlocProvider.of<ProductsBloc>(context)
                            .add(FetchProductsEvent(page: orderPage2));
                      } else {
                        orderArama = true;
                        orderPage2 = 0;
                        BlocProvider.of<ProductsBloc>(context)
                            .add(SearchProductsWithNameEvent(name: value));
                      }
                    },
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        suffixIcon: // add padding to adjust icon
                            IconButton(
                          onPressed: () {
                            _controller.clear();
                            orderArama = false;
                            orderPage2 = 0;
                            BlocProvider.of<ProductsBloc>(context)
                                .add(FetchProductsEvent(page: orderPage2));
                          },
                          icon: Icon(Icons.clear),
                        ),
                        labelText: "Stok Adını veya Stok Kodunu Giriniz",
                        hintText: "Stok Adı/Stok Kodu",
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
          Expanded(
            child: BlocBuilder<ProductsBloc, ProductsState>(
              bloc: _productsBloc,
              builder: (context, ProductsState state) {
                if (state is ProductsLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductsLoadedState) {
                  return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.products.length,
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
                                                ProductsDetayBloc>(context),
                                            child: ProductDetay(
                                              stkkod:
                                                  state.products[index].stkkod,
                                            ),
                                          )));
                            },
                            title: Text(state.products[index].stkadi),
                            subtitle:
                                Text(state.products[index].stkast.toString()),
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
}
