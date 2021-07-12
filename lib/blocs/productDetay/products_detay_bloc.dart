import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_asten_app/data/products_detay_repository.dart';
import 'package:flutter_asten_app/models/product_detayM.dart';

import '../../locater.dart';

part 'products_detay_event.dart';
part 'products_detay_state.dart';

class ProductsDetayBloc extends Bloc<ProductsDetayEvent, ProductsDetayState> {
  final ProductsDetayRepository productsDetayRepository =
      getIt<ProductsDetayRepository>();
  ProductsDetayBloc() : super(ProductsDetayInitial());

  @override
  Stream<ProductsDetayState> mapEventToState(
    ProductsDetayEvent event,
  ) async* {
    if (event is FetchProductsDetayEvent) {
      yield ProductsDetayLoadingState();
      try {
        final products =
            await productsDetayRepository.getProductListDetay(event.stkkod);

        yield ProductsDetayLoadedState(products: products);
      } catch (_) {
        yield ProductsDetayErrorState();
      }
    }
  }
}
