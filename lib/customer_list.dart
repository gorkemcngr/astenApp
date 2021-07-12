import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/costumersdetay/customers_detay_bloc.dart';
import 'blocs/customers/customers_bloc.dart';

import 'customer_detay.dart';
import 'deliveries_detay.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  var formKey2 = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();
  int customerPage = 0;
  bool deliveryArama = false;
  var _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _customersBloc = context.read<CustomersBloc>();
    _customersBloc.add(FetchCustomersEvent(page: customerPage));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        customerPage++;
        if (deliveryArama == false) {
          _customersBloc.add(FetchMoreCustomersEvent(page: customerPage));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _deliveriesBloc = context.read<CustomersBloc>();
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
                            customerPage = 0;
                            BlocProvider.of<CustomersBloc>(context)
                                .add(FetchCustomersEvent(page: customerPage));
                          } else {
                            deliveryArama = true;
                            customerPage = 0;
                            BlocProvider.of<CustomersBloc>(context)
                                .add(SearchCustomersWithNameEvent(name: value));
                          }
                        },
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            suffixIcon: // add padding to adjust icon
                                IconButton(
                              onPressed: () {
                                _controller.clear();
                                deliveryArama = false;
                                customerPage = 0;
                                BlocProvider.of<CustomersBloc>(context).add(
                                    FetchCustomersEvent(page: customerPage));
                              },
                              icon: Icon(Icons.clear),
                            ),
                            labelText: "Firma adını veya Firma kodunuz giriniz",
                            hintText: "Firma Adı/Firma Kodu",
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
            builder: (context, CustomersState state) {
              if (state is CustomersLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CustomersLoadedState) {
                return ListView.builder(
                    controller: _scrollController,
                    itemCount: (state as CustomersLoadedState).customers.length,
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
                                              CustomersDetayBloc>(context),
                                          child: CustomerDetay(
                                            sidnum:
                                                state.customers[index].firkod,
                                          ),
                                        )));
                          },
                          title: Text((state as CustomersLoadedState)
                              .customers[index]
                              .firadi),
                          subtitle: Text((state as CustomersLoadedState)
                              .customers[index]
                              .firkod),
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
