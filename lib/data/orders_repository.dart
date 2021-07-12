import 'dart:convert';

import 'package:flutter_asten_app/models/order_detayM.dart';
import 'package:flutter_asten_app/models/order_list.dart';
import 'package:http/http.dart' as http;

List<OrderList> orders = [];
List<OrderDetayM> ordersDetay = [];

String _username = 'admin';
String _password = "hV5d}'G8Hr7_WSQ]";
String _basicAuth =
    'Basic ' + base64Encode(utf8.encode('$_username:$_password'));

class OrdersRepository {
  Future<List<OrderList>> getOrderList(int page) async {
    orders.clear();
    List<OrderList> orders2 = [];
    var url2 = Uri.parse("http://193.149.3.37/orderlist/" + page.toString());

    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      orders.add(OrderList.fromJson(decodedJson[i]));
    }
    for (int i = 0; i < orders.length; i++) {
      orders2.add(orders[i]);
      orders2[i].tarih = tarihDonustur(orders2[i].siptar.toString());
    }

    return orders2;
  }

  Future<List<OrderList>> getOpenOrderList(int page) async {
    orders.clear();
    List<OrderList> orders2 = [];
    var url2 = Uri.parse("http://193.149.3.37/orderlist/" +
        page.toString() +
        "?openorders=True");

    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      orders.add(OrderList.fromJson(decodedJson[i]));
    }
    for (int i = 0; i < orders.length; i++) {
      orders2.add(orders[i]);
      orders2[i].tarih = tarihDonustur(orders2[i].siptar.toString());
    }

    return orders2;
  }

  Future<List<OrderList>> getMoreOrderList(int page) async {
    List<OrderList> orders2 = [];
    var url2 = Uri.parse("http://193.149.3.37/orderlist/" + page.toString());

    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      orders.add(OrderList.fromJson(decodedJson[i]));
    }
    for (int i = 0; i < orders.length; i++) {
      orders2.add(orders[i]);
      orders2[i].tarih = tarihDonustur(orders2[i].siptar.toString());
    }

    return orders2;
  }

  Future<List<OrderList>> getMoreOpenOrderList(int page) async {
    List<OrderList> orders2 = [];
    var url2 = Uri.parse("http://193.149.3.37/orderlist/" +
        page.toString() +
        "?openorders=True");

    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      orders.add(OrderList.fromJson(decodedJson[i]));
    }
    for (int i = 0; i < orders.length; i++) {
      orders2.add(orders[i]);
      orders2[i].tarih = tarihDonustur(orders2[i].siptar.toString());
    }

    return orders2;
  }

  Future<List<OrderList>> getOrderListWithName(var name) async {
    var arananOrder;
    try {
      arananOrder = int.parse(name);
      List<OrderList> orders2 = [];
      ordersDetay.clear();
      var url2 = Uri.parse("http://193.149.3.37/search/orders/" + name);
      final response =
          await http.get(url2, headers: {'authorization': _basicAuth});
      List decodedJson = json.decode(utf8.decode(response.bodyBytes));

      for (int i = 0; i < decodedJson.length; i++) {
        orders2.add(OrderList.fromJson(decodedJson[i]));
      }
      for (int i = 0; i < orders2.length; i++) {
        orders.add(orders2[i]);
        orders2[i].tarih = tarihDonustur(orders2[i].siptar.toString());
      }
<<<<<<< HEAD

=======
      print(ordersDetay[0].firadi);
>>>>>>> da380f049d5fc7b8a8f770711d720d6c9fa1919a
      return orders;
    } catch (e) {
      arananOrder = name;

      List<OrderList> orders2 = [];
      orders.clear();
      var url2 =
          Uri.parse("http://193.149.3.37/search/orders/" + name.toString());
      final response =
          await http.get(url2, headers: {'authorization': _basicAuth});
      List decodedJson = json.decode(utf8.decode(response.bodyBytes));

      for (int i = 0; i < decodedJson.length; i++) {
        orders.add(OrderList.fromJson(decodedJson[i]));
      }
      for (int i = 0; i < orders.length; i++) {
        orders2.add(orders[i]);
        orders2[i].tarih = tarihDonustur(orders2[i].siptar.toString());
      }

      return orders2;
    }
  }

  Future<List<OrderList>> getOpenOrderListWithName(var name) async {
    var arananOrder;
    try {
      arananOrder = int.parse(name);
      List<OrderList> orders2 = [];
      ordersDetay.clear();
      var url2 = Uri.parse("http://193.149.3.37/search/openorders/" + name);
      final response =
          await http.get(url2, headers: {'authorization': _basicAuth});
      List decodedJson = json.decode(utf8.decode(response.bodyBytes));

      for (int i = 0; i < decodedJson.length; i++) {
        orders2.add(OrderList.fromJson(decodedJson[i]));
      }
      for (int i = 0; i < orders2.length; i++) {
        orders.add(orders2[i]);
        orders2[i].tarih = tarihDonustur(orders2[i].siptar.toString());
      }
<<<<<<< HEAD

=======
      print(ordersDetay[0].firadi);
>>>>>>> da380f049d5fc7b8a8f770711d720d6c9fa1919a
      return orders;
    } catch (e) {
      arananOrder = name;

      List<OrderList> orders2 = [];
      orders.clear();
      var url2 =
          Uri.parse("http://193.149.3.37/search/openorders/" + name.toString());
      final response =
          await http.get(url2, headers: {'authorization': _basicAuth});
      List decodedJson = json.decode(utf8.decode(response.bodyBytes));

      for (int i = 0; i < decodedJson.length; i++) {
        orders.add(OrderList.fromJson(decodedJson[i]));
      }
      for (int i = 0; i < orders.length; i++) {
        orders2.add(orders[i]);
        orders2[i].tarih = tarihDonustur(orders2[i].siptar.toString());
      }

      return orders2;
    }
  }
}

String tarihDonustur(String tarih) {
  var arr = tarih.split(' ');
  String tarih1 = arr[0];
  var arr1 = tarih1.split('-');
  String tarihSonHal = arr1[2] + "/" + arr1[1] + "/" + arr1[0];
  return tarihSonHal;
}
