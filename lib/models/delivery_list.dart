// To parse this JSON data, do
//
//     final deliveryList = deliveryListFromJson(jsonString);

import 'dart:convert';

List<DeliveryList> deliveryListFromJson(String str) => List<DeliveryList>.from(
    json.decode(str).map((x) => DeliveryList.fromJson(x)));

String deliveryListToJson(List<DeliveryList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliveryList {
  DeliveryList({this.firadi, this.sevitr, this.sednum, this.rn, this.tarih});

  String firadi;
  DateTime sevitr;
  int sednum;
  int rn;
  String tarih;

  factory DeliveryList.fromJson(Map<String, dynamic> json) => DeliveryList(
        firadi: json["firadi"] == null ? "-" : json["firadi"],
        sevitr: json["sevitr"] == null ? "-" : DateTime.parse(json["sevitr"]),
        sednum: json["sednum"] == null ? "-" : json["sednum"],
        rn: json["rn"] == null ? null : json["rn"],
      );

  Map<String, dynamic> toJson() => {
        "firadi": firadi == null ? null : firadi,
        "sevitr": sevitr == null ? null : sevitr.toIso8601String(),
        "sednum": sednum == null ? null : sednum,
        "rn": rn == null ? null : rn,
      };
}
