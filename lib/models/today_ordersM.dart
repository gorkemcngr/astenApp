// To parse this JSON data, do
//
//     final todayOrdersM = todayOrdersMFromJson(jsonString);

import 'dart:convert';

List<TodayOrdersM> todayOrdersMFromJson(String str) => List<TodayOrdersM>.from(
    json.decode(str).map((x) => TodayOrdersM.fromJson(x)));

String todayOrdersMToJson(List<TodayOrdersM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodayOrdersM {
  TodayOrdersM({
    this.firadi,
    this.firkod,
    this.sidnum,
    this.siptar,
    this.total,
  });

  String firadi;
  String firkod;
  int sidnum;
  String siptar;
  double total;
  String tarih;

  factory TodayOrdersM.fromJson(Map<String, dynamic> json) => TodayOrdersM(
        firadi: json["firadi"] == null ? null : json["firadi"],
        firkod: json["firkod"] == null ? null : json["firkod"],
        sidnum: json["sidnum"] == null ? null : json["sidnum"],
        siptar: json["siptar"] == null ? null : json["siptar"],
        total: json["total"] == null ? null : json["total"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "firadi": firadi == null ? null : firadi,
        "firkod": firkod == null ? null : firkod,
        "sidnum": sidnum == null ? null : sidnum,
        "siptar": siptar == null ? null : siptar,
        "total": total == null ? null : total,
      };
}
