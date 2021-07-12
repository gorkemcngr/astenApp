import 'dart:convert';

import 'package:flutter_asten_app/deliveries_listesi.dart';
import 'package:flutter_asten_app/models/deliveriesM.dart';
import 'package:http/http.dart' as http;

String _username = 'admin';
String _password = "hV5d}'G8Hr7_WSQ]";
String _basicAuth =
    'Basic ' + base64Encode(utf8.encode('$_username:$_password'));

class DeliveriesDetayRepository {
  List<DeliveriesM> deliveriesDetay = [];

  Future<List<DeliveriesM>> getDeliveryListDetay(int sednum) async {
    double toplam = 0;
    List<DeliveriesM> deliveries2 = [];
    deliveriesDetay.clear();
    var url2 = Uri.parse("http://193.149.3.37/deliveries/" + sednum.toString());
    final response =
        await http.get(url2, headers: {'authorization': _basicAuth});
    List decodedJson = json.decode(utf8.decode(response.bodyBytes));

    for (int i = 0; i < decodedJson.length; i++) {
      print("şuan burada1");
      deliveries2.add(DeliveriesM.fromJson(decodedJson[i]));
      toplam = toplam + deliveries2[i].sidufy;
    }
    print("şuan burada2");
    deliveries2[0].toplam = toplam;
    deliveries2[0].tarih = tarihDonustur(deliveries2[0].sevitr.toString());
    var arr = deliveries2[0].sevirs.toString().split('/');
    if (arr.length > 1) {
      deliveries2[0].irsaliyeNo = arr[1];
    }
    deliveries2[0].kargo = arr[0];

    for (int i = 0; i < deliveries2.length; i++) {
      deliveriesDetay.add(deliveries2[i]);
    }
    if (deliveriesDetay[0].sidpbr == "TRL") {
      deliveriesDetay[0].typeOfMoney = "₺";
    } else if (deliveriesDetay[0].sidpbr == "eur") {
      deliveriesDetay[0].typeOfMoney = "€";
    } else if (deliveriesDetay[0].sidpbr == "USD") {
      deliveriesDetay[0].typeOfMoney = "\$";
    }
    print(deliveriesDetay[0].firadi);

    return deliveriesDetay;
  }
}

String tarihDonustur(String tarih) {
  var arr = tarih.split(' ');
  String tarih1 = arr[0];
  var arr1 = tarih1.split('-');
  String tarihSonHal = arr1[2] + "/" + arr1[1] + "/" + arr1[0];
  return tarihSonHal;
}
