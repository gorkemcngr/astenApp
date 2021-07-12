// To parse this JSON data, do
//
//     final todayOrderDetayM = todayOrderDetayMFromJson(jsonString);

import 'dart:convert';

List<TodayOrderDetayM> todayOrderDetayMFromJson(String str) =>
    List<TodayOrderDetayM>.from(
        json.decode(str).map((x) => TodayOrderDetayM.fromJson(x)));

String todayOrderDetayMToJson(List<TodayOrderDetayM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodayOrderDetayM {
  TodayOrderDetayM({
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
  double sidmik;
  double sidtut;
  String siptar;
  String sidpbr;
  String sidozl;
  String sidtj;
  int sidsno;
  String typeOfMoney;
  String tarih;
  double toplam;

  factory TodayOrderDetayM.fromJson(Map<String, dynamic> json) =>
      TodayOrderDetayM(
        firadi: json["firadi"] == null ? null : json["firadi"],
        firkod: json["firkod"] == null ? null : json["firkod"],
        sidufy: json["sidufy"] == null ? null : json["sidufy"],
        sidnum: json["sidnum"] == null ? null : json["sidnum"],
        sidstk: json["sidstk"] == null ? null : json["sidstk"],
        stkadi: json["stkadi"] == null ? null : json["stkadi"],
        sidmik: json["sidmik"] == null ? null : json["sidmik"],
        sidtut: json["sidtut"] == null ? null : json["sidtut"].toDouble(),
        siptar: json["siptar"] == null ? null : json["siptar"],
        sidpbr: json["sidpbr"] == null ? null : json["sidpbr"],
        sidozl: json["sidozl"] == null ? null : json["sidozl"],
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
        "sidtj": sidtj == null ? null : sidtj,
        "sidsno": sidsno == null ? null : sidsno,
      };
}
