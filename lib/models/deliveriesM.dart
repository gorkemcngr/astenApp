// To parse this JSON data, do
//
//     final deliveriesM = deliveriesMFromJson(jsonString);

import 'dart:convert';

List<DeliveriesM> deliveriesMFromJson(String str) => List<DeliveriesM>.from(
    json.decode(str).map((x) => DeliveriesM.fromJson(x)));

String deliveriesMToJson(List<DeliveriesM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliveriesM {
  DeliveriesM(
      {this.firadi,
      this.firkod,
      this.sidnum,
      this.sidstk,
      this.stkadi,
      this.sedmik,
      this.sidufy,
      this.sidttr,
      this.sidpbr,
      this.sidozl,
      this.sevirs,
      this.sevtad,
      this.sevitr,
      this.sednum,
      this.sidmik,
      this.stpadi,
      this.sipmyt,
      this.sidtj,
      this.faturaflag,
      this.faturaurl,
      this.tarih});

  String firadi;
  String firkod;
  int sidnum;
  String sidstk;
  String stkadi;
  double sedmik;
  double sidufy;
  DateTime sidttr;
  String sidpbr;
  dynamic sidozl;
  String sevirs;
  String sevtad;
  DateTime sevitr;
  int sednum;
  double sidmik;
  String stpadi;
  String sipmyt;
  double toplam;
  String tarih;
  String kargo;
  String typeOfMoney;
  String irsaliyeNo = "-";
  String sidtj;
  int faturaflag;
  String faturaurl;

  factory DeliveriesM.fromJson(Map<String, dynamic> json) => DeliveriesM(
        firadi: json["firadi"] == null ? "-" : json["firadi"],
        firkod: json["firkod"] == null ? "-" : json["firkod"],
        sidnum: json["sidnum"] == null ? "-" : json["sidnum"],
        sidstk: json["sidstk"] == null ? "-" : json["sidstk"],
        stkadi: json["stkadi"] == null ? "-" : json["stkadi"],
        sedmik: json["sedmik"] == null ? "-" : json["sedmik"],
        sidufy: json["sidufy"] == null ? "-" : json["sidufy"],
        sidttr: json["sidttr"] == null ? "-" : DateTime.parse(json["sidttr"]),
        sidpbr: json["sidpbr"] == null ? "-" : json["sidpbr"],
        sidozl: json["sidozl"] == null ? "-" : json["sidozl"],
        sevirs: json["sevirs"] == null ? "-" : json["sevirs"],
        sevtad: json["sevtad"] == null ? "-" : json["sevtad"],
        sevitr: json["sevitr"] == null ? "-" : DateTime.parse(json["sevitr"]),
        sednum: json["sednum"] == null ? "-" : json["sednum"],
        sidmik: json["sidmik"] == null ? "-" : json["sidmik"],
        stpadi: json["stpadi"] == null ? "-" : json["stpadi"],
        sipmyt: json["sipmyt"] == null ? "-" : json["sipmyt"],
        sidtj: json["sidtj"] == null ? null : json["sidtj"],
        faturaflag: json["faturaflag"] == null ? null : json["faturaflag"],
        faturaurl: json["faturaurl"] == null ? null : json["faturaurl"],
      );

  Map<String, dynamic> toJson() => {
        "firadi": firadi == null ? null : firadi,
        "firkod": firkod == null ? null : firkod,
        "sidnum": sidnum == null ? null : sidnum,
        "sidstk": sidstk == null ? null : sidstk,
        "stkadi": stkadi == null ? null : stkadi,
        "sedmik": sedmik == null ? null : sedmik,
        "sidufy": sidufy == null ? null : sidufy,
        "sidttr": sidttr == null ? null : sidttr.toIso8601String(),
        "sidpbr": sidpbr == null ? null : sidpbr,
        "sidozl": sidozl,
        "sevirs": sevirs == null ? null : sevirs,
        "sevtad": sevtad == null ? null : sevtad,
        "sevitr": sevitr == null ? null : sevitr.toIso8601String(),
        "sednum": sednum == null ? null : sednum,
        "sidmik": sidmik == null ? null : sidmik,
        "stpadi": stpadi == null ? null : stpadi,
        "sipmyt": sipmyt == null ? null : sipmyt,
      };
}
