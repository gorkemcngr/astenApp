// To parse this JSON data, do
//
//     final customerM = customerMFromJson(jsonString);

import 'dart:convert';

List<CustomerM> customerMFromJson(String str) =>
    List<CustomerM>.from(json.decode(str).map((x) => CustomerM.fromJson(x)));

String customerMToJson(List<CustomerM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerM {
  CustomerM({
    this.firkod,
    this.firadi,
    this.totalorder,
    this.rn,
  });

  String firkod;
  String firadi;
  int totalorder;
  int rn;

  factory CustomerM.fromJson(Map<String, dynamic> json) => CustomerM(
        firkod: json["firkod"] == null ? "-" : json["firkod"],
        firadi: json["firadi"] == null ? "-" : json["firadi"],
        totalorder: json["totalorder"] == null ? "-" : json["totalorder"],
      );

  Map<String, dynamic> toJson() => {
        "firkod": firkod == null ? null : firkod,
        "firadi": firadi == null ? null : firadi,
        "totalorder": totalorder == null ? null : totalorder,
        "rn": rn == null ? null : rn,
      };
}
