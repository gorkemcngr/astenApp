import 'dart:convert';

import 'package:flutter_asten_app/models/delivery_list.dart';
import 'package:http/http.dart' as http;

List<DeliveryList> deliveries = [];

String _username = 'admin';
String _password = "hV5d}'G8Hr7_WSQ]";
String _basicAuth =
    'Basic ' + base64Encode(utf8.encode('$_username:$_password'));

class DeliveriesRepository {
  Future<List<DeliveryList>> getDeliveryList(int page) async {
    deliveries.clear();
    List<DeliveryList> deliveries2 = [];
    var url2 = Uri.parse("http://193.149.3.37/deliverylist/" + page.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));
    print(decodedJson);

    for (int i = 0; i < decodedJson.length; i++) {
      deliveries.add(DeliveryList.fromJson(decodedJson[i]));
    }

    for (int i = 0; i < deliveries.length; i++) {
      deliveries2.add(deliveries[i]);
      deliveries2[i].tarih = tarihDonustur(deliveries2[i].sevitr.toString());
    }
    return deliveries2;
  }

  Future<List<DeliveryList>> getMoreDeliveryList(int page) async {
    List<DeliveryList> deliveries2 = [];
    var url2 = Uri.parse("http://193.149.3.37/deliverylist/" + page.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      deliveries.add(DeliveryList.fromJson(decodedJson[i]));
    }

    for (int i = 0; i < deliveries.length; i++) {
      deliveries2.add(deliveries[i]);
      deliveries2[i].tarih = tarihDonustur(deliveries2[i].sevitr.toString());
    }

    return deliveries2;
  }

  Future<List<DeliveryList>> getDeliveryListWithName(var name) async {
    List<DeliveryList> deliveries2 = [];
    var arananOrder;

    arananOrder = name;

    deliveries.clear();
    var url2 =
        Uri.parse("http://193.149.3.37/search/deliveries/" + name.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      deliveries.add(DeliveryList.fromJson(decodedJson[i]));
    }
    for (int i = 0; i < deliveries.length; i++) {
      deliveries2.add(deliveries[i]);
      deliveries2[i].tarih = tarihDonustur(deliveries2[i].sevitr.toString());
    }

    return deliveries2;
  }
}

String tarihDonustur(String tarih) {
  var arr = tarih.split(' ');
  String tarih1 = arr[0];
  var arr1 = tarih1.split('-');
  String tarihSonHal = arr1[2] + "/" + arr1[1] + "/" + arr1[0];
  return tarihSonHal;
}
