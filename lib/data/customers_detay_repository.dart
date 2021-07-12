import 'dart:convert';
import 'package:flutter_asten_app/models/customers_detayM.dart';
import 'package:http/http.dart' as http;

String _username = 'admin';
String _password = "hV5d}'G8Hr7_WSQ]";
String _basicAuth =
    'Basic ' + base64Encode(utf8.encode('$_username:$_password'));

class CustomersDetayRepository {
  List<CustomerDetayM> customersDetay = [];

  Future<List<CustomerDetayM>> getCustomerListDetay(String firkod) async {
    double toplam = 0;
    List<CustomerDetayM> customerDetay2 = [];
    customersDetay.clear();
    var url2 = Uri.parse("http://193.149.3.37/customers/" + firkod.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      customerDetay2.add(CustomerDetayM.fromJson(decodedJson[i]));
    }
    int counter = 1;
    for (int i = 0; i < customerDetay2.length; i++) {
      customersDetay.add(customerDetay2[i]);
      customersDetay[i].adresCount = counter++;
    }

    return customersDetay;
  }
}
