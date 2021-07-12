import 'package:flutter_asten_app/models/today_ordersM.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<TodayOrdersM> orders = [];

String _username = 'admin';
String _password = "hV5d}'G8Hr7_WSQ]";
String _basicAuth =
    'Basic ' + base64Encode(utf8.encode('$_username:$_password'));

class TodayOrdersRepository {
  Future<List<TodayOrdersM>> getTodayOrderList(int page) async {
    orders.clear();
    List<TodayOrdersM> orders2 = [];
    var url2 = Uri.parse("http://193.149.3.37/orderlist/" +
        page.toString() +
        "?openorders=True&today=true");

    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      orders.add(TodayOrdersM.fromJson(decodedJson[i]));
    }
    for (int i = 0; i < orders.length; i++) {
      orders2.add(orders[i]);
      orders2[i].tarih = tarihDonustur(orders2[i].siptar.toString());
    }

    return orders2;
  }

  Future<List<TodayOrdersM>> getMoreTodayOrderList(int page) async {
    List<TodayOrdersM> deliveries2 = [];
    var url2 = Uri.parse("http://193.149.3.37/orderlist/" +
        page.toString() +
        "?openorders=True&today=true");
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      orders.add(TodayOrdersM.fromJson(decodedJson[i]));
    }

    for (int i = 0; i < orders.length; i++) {
      deliveries2.add(orders[i]);
      deliveries2[i].tarih = tarihDonustur(deliveries2[i].siptar.toString());
    }

    return deliveries2;
  }

  Future<List<TodayOrdersM>> getTodayOrderListWithName(var name) async {
    List<TodayOrdersM> orders2 = [];
    var arananOrder;

    arananOrder = name;

    orders.clear();
    var url2 =
        Uri.parse("http://193.149.3.37/search/deliveries/" + name.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));
<<<<<<< HEAD

=======
    print("a");
>>>>>>> da380f049d5fc7b8a8f770711d720d6c9fa1919a
    for (int i = 0; i < decodedJson.length; i++) {
      orders.add(TodayOrdersM.fromJson(decodedJson[i]));
    }
    for (int i = 0; i < orders.length; i++) {
      orders2.add(orders[i]);
      orders2[i].tarih = tarihDonustur(orders2[i].siptar.toString());
    }

    return orders2;
  }
}

String tarihDonustur(String tarih) {
  var arr = tarih.split('T');
  String tarih1 = arr[0];
  var arr1 = tarih1.split('-');
  String tarihSonHal = arr1[2] + "/" + arr1[1] + "/" + arr1[0];
  return tarihSonHal;
}
