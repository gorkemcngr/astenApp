import 'dart:convert';
import 'package:flutter_asten_app/models/today_orders_detayM.dart';
import 'package:http/http.dart' as http;

String _username = 'admin';
String _password = "hV5d}'G8Hr7_WSQ]";
String _basicAuth =
    'Basic ' + base64Encode(utf8.encode('$_username:$_password'));

class TodayOrdersDetayRepository {
  List<TodayOrderDetayM> ordersDetay = [];

  Future<List<TodayOrderDetayM>> getTodayOrderDetayListDetay(int sidnum) async {
    double toplam = 0;

    List<TodayOrderDetayM> orders2 = [];
    ordersDetay.clear();
    var url2 = Uri.parse("http://193.149.3.37/orders/" +
        sidnum.toString() +
        "?openorders=True&today=True");
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      orders2.add(TodayOrderDetayM.fromJson(decodedJson[i]));

      toplam = toplam + orders2[i].sidtut;
    }

    orders2[0].toplam = toplam;

    for (int i = 0; i < orders2.length; i++) {
      ordersDetay.add(orders2[i]);

      ordersDetay[i].tarih = tarihDonustur(ordersDetay[i].siptar.toString());
    }

    if (ordersDetay[0].sidpbr == "TRL") {
      ordersDetay[0].typeOfMoney = "₺";
    } else if (ordersDetay[0].sidpbr == "eur") {
      ordersDetay[0].typeOfMoney = "€";
    } else if (ordersDetay[0].sidpbr == "USD") {
      ordersDetay[0].typeOfMoney = "\$";
    }

    return ordersDetay;
  }
}

String tarihDonustur(String tarih) {
  var arr = tarih.split('T');
  String tarih1 = arr[0];
  var arr1 = tarih1.split('-');
  String tarihSonHal = arr1[2] + "/" + arr1[1] + "/" + arr1[0];
  return tarihSonHal;
}