import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/deliveries/deliveries_bloc.dart';
import 'blocs/deliveriesdetay/deliveries_detay_bloc.dart';
import 'deliveries_detay.dart';

class Deliveries extends StatefulWidget {
  @override
  _DeliveriesState createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> {
  var formKey2 = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();
  int deliveryPage = 0;
  bool deliveryArama = false;
  var _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _deliveriesBloc = context.read<DeliveriesBloc>();
    _deliveriesBloc.add(FetchDeliveriesEvent(page: deliveryPage));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        deliveryPage++;
        if (deliveryArama == false) {
          _deliveriesBloc.add(FetchMoreDeliveriesEvent(page: deliveryPage));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _deliveriesBloc = context.read<DeliveriesBloc>();
    return Column(
      children: [
        Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Form(
                      key: formKey2,
                      child: TextFormField(
                        controller: _controller,
                        onChanged: (value) {
                          if (value.length == 0) {
                            deliveryArama = false;
                            deliveryPage = 0;
                            BlocProvider.of<DeliveriesBloc>(context)
                                .add(FetchDeliveriesEvent(page: deliveryPage));
                          } else {
                            deliveryArama = true;
                            deliveryPage = 0;
                            BlocProvider.of<DeliveriesBloc>(context).add(
                                SearchDeliveriesWithNameEvent(name: value));
                          }
                        },
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            suffixIcon: // add padding to adjust icon
                                IconButton(
                              onPressed: () {
                                _controller.clear();
                                deliveryArama = false;
                                deliveryPage = 0;
                                BlocProvider.of<DeliveriesBloc>(context).add(
                                    FetchDeliveriesEvent(page: deliveryPage));
                              },
                              icon: Icon(Icons.clear),
                            ),
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
                        onSaved: (value) {},
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
              child: BlocBuilder(
            bloc: _deliveriesBloc,
            builder: (context, DeliveriesState state) {
              if (state is DeliveriesLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is DeliveriesLoadedState) {
                return ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        (state as DeliveriesLoadedState).deliveries.length,
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
                                              DeliveriesDetayBloc>(context),
                                          child: DeliveriesDetay(
                                            sednum:
                                                state.deliveries[index].sednum,
                                          ),
                                        )));
                          },
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.deliveries[index].sednum.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(state.deliveries[index].firadi),
                            ],
                          ),
                          subtitle: Text((state as DeliveriesLoadedState)
                              .deliveries[index]
                              .tarih
                              .toString()),
                        ),
                      );
                    });
              } else {
                return null;
              }
            },
          )),
        ),
      ],
    );
  }
}
