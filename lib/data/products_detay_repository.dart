import 'dart:convert';

import 'package:flutter_asten_app/models/product_detayM.dart';
import 'package:http/http.dart' as http;

String _username = 'admin';
String _password = "hV5d}'G8Hr7_WSQ]";
String _basicAuth =
    'Basic ' + base64Encode(utf8.encode('$_username:$_password'));

class ProductsDetayRepository {
  List<ProductDetayM> productsDetay = [];

  Future<List<ProductDetayM>> getProductListDetay(String stkkod) async {
    double toplam = 0;
    List<ProductDetayM> productsDetay2 = [];
    productsDetay.clear();
    var url2 = Uri.parse("http://193.149.3.37/products/" + stkkod.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      print("aha geldii");
      productsDetay2.add(ProductDetayM.fromJson(decodedJson[i]));
      print("aha geldii222");
    }
    int counter = 1;
    for (int i = 0; i < productsDetay2.length; i++) {
      productsDetay.add(productsDetay2[i]);
    }

    return productsDetay;
  }
}
