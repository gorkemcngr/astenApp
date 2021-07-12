// To parse this JSON data, do
//
//     final productM = productMFromJson(jsonString);

import 'dart:convert';

List<ProductM> productMFromJson(String str) =>
    List<ProductM>.from(json.decode(str).map((x) => ProductM.fromJson(x)));

String productMToJson(List<ProductM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductM {
  ProductM({
    this.stkast,
    this.stkkod,
    this.stkadi,
    this.totalq,
    this.rn,
  });

  String stkast;
  String stkkod;
  String stkadi;
  double totalq;
  int rn;

  factory ProductM.fromJson(Map<String, dynamic> json) => ProductM(
        stkast: json["stkast"] == null ? null : json["stkast"],
        stkkod: json["stkkod"] == null ? null : json["stkkod"],
        stkadi: json["stkadi"] == null ? null : json["stkadi"],
        totalq: json["totalq"] == null ? null : json["totalq"],
      );

  Map<String, dynamic> toJson() => {
        "stkast": stkast == null ? null : stkast,
        "stkkod": stkkod == null ? null : stkkod,
        "stkadi": stkadi == null ? null : stkadi,
        "totalq": totalq == null ? null : totalq,
        "rn": rn == null ? null : rn,
      };
}
