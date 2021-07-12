// To parse this JSON data, do
//
//     final orderList = orderListFromJson(jsonString);

import 'dart:convert';

List<OrderList> orderListFromJson(String str) =>
    List<OrderList>.from(json.decode(str).map((x) => OrderList.fromJson(x)));

String orderListToJson(List<OrderList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderList {
  OrderList({
    this.firadi,
    this.firkod,
    this.sidnum,
    this.siptar,
    this.total,
    this.rn,
  });

  String firadi;
  String firkod;
  int sidnum;
  DateTime siptar;
  double total;
  String tarih;
  int rn;

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        firadi: json["firadi"] == null ? "-" : json["firadi"],
        firkod: json["firkod"] == null ? "-" : json["firkod"],
        sidnum: json["sidnum"] == null ? "-" : json["sidnum"],
        siptar: json["siptar"] == null ? "-" : DateTime.parse(json["siptar"]),
        total: json["total"] == null ? "-" : json["total"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "firadi": firadi == null ? null : firadi,
        "firkod": firkod == null ? null : firkod,
        "sidnum": sidnum == null ? null : sidnum,
        "siptar": siptar == null ? null : siptar.toIso8601String(),
        "total": total == null ? null : total,
        "rn": rn == null ? null : rn,
      };
}
