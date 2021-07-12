// To parse this JSON data, do
//
//     final orderDetayM = orderDetayMFromJson(jsonString);

import 'dart:convert';

List<OrderDetayM> orderDetayMFromJson(String str) => List<OrderDetayM>.from(
    json.decode(str).map((x) => OrderDetayM.fromJson(x)));

String orderDetayMToJson(List<OrderDetayM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetayM {
  OrderDetayM({
    this.firadi,
    this.firkod,
    this.sidnum,
    this.sidufy,
    this.sidstk,
    this.stkadi,
    this.sidmik,
    this.sidtut,
    this.siptar,
    this.sidpbr,
    this.sidozl,
    this.sidtj,
    this.sidsno,
  });

  String firadi;
  String firkod;
  int sidnum;
  double sidufy;
  String sidstk;
  String stkadi;
  double toplam;
  double sidmik;
  double sidtut;
  String siptar;
  String sidpbr;
  String sidozl;
  String tarih;
  String typeOfMoney;
  String sidtj;
  int sidsno;

  factory OrderDetayM.fromJson(Map<String, dynamic> json) => OrderDetayM(
        firadi: json["firadi"] == null ? "-" : json["firadi"],
        firkod: json["firkod"] == null ? "-" : json["firkod"],
        sidnum: json["sidnum"] == null ? "-" : json["sidnum"],
        sidstk: json["sidstk"] == null ? "-" : json["sidstk"],
        sidmik: json["sidmik"] == null ? "-" : json["sidmik"],
        sidufy: json["sidufy"] == null ? "-" : json["sidufy"],
        stkadi: json["stkadi"] == null ? "-" : json["stkadi"],
        sidtut: json["sidtut"] == null ? "-" : json["sidtut"].toDouble(),
        siptar: json["siptar"] == null ? "-" : json["siptar"],
        sidpbr: json["sidpbr"] == null ? "-" : json["sidpbr"],
        sidozl: json["sidozl"] == null ? "-" : json["sidozl"],
        sidtj: json["sidtj"] == null ? null : json["sidtj"],
        sidsno: json["sidsno"] == null ? null : json["sidsno"],
      );

  Map<String, dynamic> toJson() => {
        "firadi": firadi == null ? null : firadi,
        "firkod": firkod == null ? null : firkod,
        "sidnum": sidnum == null ? null : sidnum,
        "sidufy": sidufy == null ? null : sidufy,
        "sidstk": sidstk == null ? null : sidstk,
        "stkadi": stkadi == null ? null : stkadi,
        "sidmik": sidmik == null ? null : sidmik,
        "sidtut": sidtut == null ? null : sidtut,
        "siptar": siptar == null ? null : siptar,
        "sidpbr": sidpbr == null ? null : sidpbr,
        "sidozl": sidozl == null ? null : sidozl,
      };
}
