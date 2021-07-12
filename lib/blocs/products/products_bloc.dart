import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_asten_app/data/products_repository.dart';
import 'package:flutter_asten_app/models/productM.dart';

import '../../locater.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository productsRepository = getIt<ProductsRepository>();
  ProductsBloc() : super(ProductsInitial());

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is FetchProductsEvent) {
      yield ProductsLoadingState();
      try {
        final products = await productsRepository.getProductList(event.page);

        yield ProductsLoadedState(products: products);
      } catch (_) {
        yield ProductsErrorState();
      }
    } else if (event is FetchMoreProductsEvent) {
      try {
        final products =
            await productsRepository.getMoreCustomerList(event.page);

        yield ProductsLoadedState(products: products);
      } catch (_) {
        yield ProductsErrorState();
      }
    } else if (event is SearchProductsWithNameEvent) {
      try {
        final products =
            await productsRepository.getCustomerListWithName(event.name);
        yield ProductsLoadedState(products: products);
      } catch (_) {
        yield ProductsErrorState();
      }
    }
  }
}
