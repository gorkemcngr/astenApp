// To parse this JSON data, do
//
//     final customerDetayM = customerDetayMFromJson(jsonString);

import 'dart:convert';

List<CustomerDetayM> customerDetayMFromJson(String str) =>
    List<CustomerDetayM>.from(
        json.decode(str).map((x) => CustomerDetayM.fromJson(x)));

String customerDetayMToJson(List<CustomerDetayM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerDetayM {
  CustomerDetayM({
    this.firkod,
    this.firadi,
    this.firtur,
    this.firvda,
    this.firvno,
    this.firweb,
    this.fireml,
    this.firtps,
    this.firups,
    this.firkps,
    this.firrsk,
    this.firpua,
    this.firdrm,
    this.firtem,
    this.firony,
    this.firnot,
    this.firamk,
    this.firsmk,
    this.firrle,
    this.firhiz,
    this.firsat,
    this.firure,
    this.firok1,
    this.firok2,
    this.firok3,
    this.firok4,
    this.firok5,
    this.adrnum,
    this.adrfir,
    this.adrtip,
    this.adrtl1,
    this.adrtl2,
    this.adrtl3,
    this.adrfx1,
    this.adrfx2,
    this.adradr,
    this.adrpkd,
    this.adrilc,
    this.adrseh,
    this.adrulk,
  });

  String firkod;
  String firadi;
  String firtur;
  String firvda;
  String firvno;
  dynamic firweb;
  String fireml;
  dynamic firtps;
  dynamic firups;
  dynamic firkps;
  String firrsk;
  dynamic firpua;
  String firdrm;
  String firtem;
  String firony;
  dynamic firnot;
  dynamic firamk;
  dynamic firsmk;
  String firrle;
  dynamic firhiz;
  dynamic firsat;
  dynamic firure;
  dynamic firok1;
  dynamic firok2;
  dynamic firok3;
  dynamic firok4;
  dynamic firok5;
  int adrnum;
  String adrfir;
  String adrtip;
  String adrtl1;
  String adrtl2;
  int adresCount;
  dynamic adrtl3;
  String adrfx1;
  dynamic adrfx2;
  String adradr;
  dynamic adrpkd;
  String adrilc;
  String adrseh;
  dynamic adrulk;

  factory CustomerDetayM.fromJson(Map<String, dynamic> json) => CustomerDetayM(
        firkod: json["firkod"] == null ? "-" : json["firkod"],
        firadi: json["firadi"] == null ? "-" : json["firadi"],
        firtur: json["firtur"] == null ? "-" : json["firtur"],
        firvda: json["firvda"] == null ? "-" : json["firvda"],
        firvno: json["firvno"] == null ? "-" : json["firvno"],
        firweb: json["firweb"],
        fireml: json["fireml"] == null ? "-" : json["fireml"],
        firtps: json["firtps"],
        firups: json["firups"],
        firkps: json["firkps"],
        firrsk: json["firrsk"] == null ? "-" : json["firrsk"],
        firpua: json["firpua"],
        firdrm: json["firdrm"] == null ? "-" : json["firdrm"],
        firtem: json["firtem"] == null ? "-" : json["firtem"],
        firony: json["firony"] == null ? "-" : json["firony"],
        firnot: json["firnot"],
        firamk: json["firamk"],
        firsmk: json["firsmk"],
        firrle: json["firrle"] == null ? "-" : json["firrle"],
        firhiz: json["firhiz"],
        firsat: json["firsat"],
        firure: json["firure"],
        firok1: json["firok1"],
        firok2: json["firok2"],
        firok3: json["firok3"],
        firok4: json["firok4"],
        firok5: json["firok5"],
        adrnum: json["adrnum"] == null ? "-" : json["adrnum"],
        adrfir: json["adrfir"] == null ? "-" : json["adrfir"],
        adrtip: json["adrtip"] == null ? "-" : json["adrtip"],
        adrtl1: json["adrtl1"] == null ? "-" : json["adrtl1"],
        adrtl2: json["adrtl2"] == null ? "-" : json["adrtl2"],
        adrtl3: json["adrtl3"],
        adrfx1: json["adrfx1"] == null ? "-" : json["adrfx1"],
        adrfx2: json["adrfx2"],
        adradr: json["adradr"] == null ? "-" : json["adradr"],
        adrpkd: json["adrpkd"],
        adrilc: json["adrilc"] == null ? "-" : json["adrilc"],
        adrseh: json["adrseh"] == null ? "-" : json["adrseh"],
        adrulk: json["adrulk"],
      );

  Map<String, dynamic> toJson() => {
        "firkod": firkod == null ? null : firkod,
        "firadi": firadi == null ? null : firadi,
        "firtur": firtur == null ? null : firtur,
        "firvda": firvda == null ? null : firvda,
        "firvno": firvno == null ? null : firvno,
        "firweb": firweb,
        "fireml": fireml == null ? null : fireml,
        "firtps": firtps,
        "firups": firups,
        "firkps": firkps,
        "firrsk": firrsk == null ? null : firrsk,
        "firpua": firpua,
        "firdrm": firdrm == null ? null : firdrm,
        "firtem": firtem == null ? null : firtem,
        "firony": firony == null ? null : firony,
        "firnot": firnot,
        "firamk": firamk,
        "firsmk": firsmk,
        "firrle": firrle == null ? null : firrle,
        "firhiz": firhiz,
        "firsat": firsat,
        "firure": firure,
        "firok1": firok1,
        "firok2": firok2,
        "firok3": firok3,
        "firok4": firok4,
        "firok5": firok5,
        "adrnum": adrnum == null ? null : adrnum,
        "adrfir": adrfir == null ? null : adrfir,
        "adrtip": adrtip == null ? null : adrtip,
        "adrtl1": adrtl1 == null ? null : adrtl1,
        "adrtl2": adrtl2 == null ? null : adrtl2,
        "adrtl3": adrtl3,
        "adrfx1": adrfx1 == null ? null : adrfx1,
        "adrfx2": adrfx2,
        "adradr": adradr == null ? null : adradr,
        "adrpkd": adrpkd,
        "adrilc": adrilc == null ? null : adrilc,
        "adrseh": adrseh == null ? null : adrseh,
        "adrulk": adrulk,
      };
}
