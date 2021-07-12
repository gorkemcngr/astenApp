import 'dart:convert';

import 'package:flutter_asten_app/models/productM.dart';
import 'package:http/http.dart' as http;

List<ProductM> products = [];

String _username = 'admin';
String _password = "hV5d}'G8Hr7_WSQ]";
String _basicAuth =
    'Basic ' + base64Encode(utf8.encode('$_username:$_password'));

class ProductsRepository {
  Future<List<ProductM>> getProductList(int page) async {
    products.clear();
    List<ProductM> products2 = [];
    var url2 = Uri.parse("http://193.149.3.37/productlist/" + page.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      products.add(ProductM.fromJson(decodedJson[i]));
    }

    for (int i = 0; i < products.length; i++) {
      products2.add(products[i]);
    }
    return products2;
  }

  Future<List<ProductM>> getMoreCustomerList(int page) async {
    List<ProductM> products2 = [];
    var url2 = Uri.parse("http://193.149.3.37/productlist/" + page.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      products.add(ProductM.fromJson(decodedJson[i]));
    }

    for (int i = 0; i < products.length; i++) {
      products2.add(products[i]);
    }

    return products2;
  }

  Future<List<ProductM>> getCustomerListWithName(var name) async {
    List<ProductM> products2 = [];

    products.clear();
    var url2 =
        Uri.parse("http://193.149.3.37/search/products/" + name.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      products.add(ProductM.fromJson(decodedJson[i]));
    }
    for (int i = 0; i < products.length; i++) {
      products2.add(products[i]);
    }

    return products2;
  }
}
