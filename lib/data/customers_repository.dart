import 'dart:convert';

import 'package:flutter_asten_app/models/customerM.dart';
import 'package:http/http.dart' as http;

List<CustomerM> customers = [];

String _username = 'admin';
String _password = "hV5d}'G8Hr7_WSQ]";
String _basicAuth =
    'Basic ' + base64Encode(utf8.encode('$_username:$_password'));

class CustomersRepository {
  Future<List<CustomerM>> getCustomerList(int page) async {
    customers.clear();
    List<CustomerM> customers2 = [];
    var url2 = Uri.parse("http://193.149.3.37/customerlist/" + page.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));
<<<<<<< HEAD
=======
    print(decodedJson);
>>>>>>> da380f049d5fc7b8a8f770711d720d6c9fa1919a

    for (int i = 0; i < decodedJson.length; i++) {
      customers.add(CustomerM.fromJson(decodedJson[i]));
    }

    for (int i = 0; i < customers.length; i++) {
      customers2.add(customers[i]);
    }
    return customers2;
  }

  Future<List<CustomerM>> getMoreCustomerList(int page) async {
    List<CustomerM> customers2 = [];
    var url2 = Uri.parse("http://193.149.3.37/customerlist/" + page.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      customers.add(CustomerM.fromJson(decodedJson[i]));
    }

    for (int i = 0; i < customers.length; i++) {
      customers2.add(customers[i]);
    }

    return customers2;
  }

  Future<List<CustomerM>> getCustomerListWithName(var name) async {
    List<CustomerM> customers2 = [];

    customers.clear();
    var url2 =
        Uri.parse("http://193.149.3.37/search/customers/" + name.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));
<<<<<<< HEAD
=======
    print("a");
>>>>>>> da380f049d5fc7b8a8f770711d720d6c9fa1919a
    for (int i = 0; i < decodedJson.length; i++) {
      customers.add(CustomerM.fromJson(decodedJson[i]));
    }
    for (int i = 0; i < customers.length; i++) {
      customers2.add(customers[i]);
    }

    return customers2;
  }
}
