// To parse this JSON data, do
//
//     final productDetayM = productDetayMFromJson(jsonString);

import 'dart:convert';

List<ProductDetayM> productDetayMFromJson(String str) =>
    List<ProductDetayM>.from(
        json.decode(str).map((x) => ProductDetayM.fromJson(x)));

String productDetayMToJson(List<ProductDetayM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDetayM {
  ProductDetayM({
    this.stktip,
    this.stkkod,
    this.stkadi,
    this.stkad2,
    this.stkokd,
    this.stkres,
    this.stkrrv,
    this.stkbrm,
    this.stkcns,
    this.stktsk,
    this.stktsu,
    this.stktsb,
    this.stkkac,
    this.stkgrp,
    this.stkag1,
    this.stkag2,
    this.stkbar,
    this.stkrev,
    this.stkrtr,
    this.stkmin,
    this.stkmsm,
    this.stkmfy,
    this.stkmbr,
    this.stkmtr,
    this.stkkdv,
    this.stkrom,
    this.stkomr,
    this.stkocs,
    this.stkskl,
    this.stkizl,
    this.stkcik,
    this.stkeni,
    this.stkenb,
    this.stkboy,
    this.stkbob,
    this.stkder,
    this.stkdeb,
    this.stkcap,
    this.stkcab,
    this.stkyog,
    this.stkgky,
    this.stkagr,
    this.stksat,
    this.stknma,
    this.stknot,
    this.stkan1,
    this.stkan2,
    this.stkan3,
    this.stkan4,
    this.stkan5,
    this.stkln1,
    this.stkln2,
    this.stkln3,
    this.stkln4,
    this.stkln5,
    this.stkusr,
    this.stkcrt,
    this.tozstp,
    this.tozstk,
    this.tozadi,
    this.tozdeg,
    this.tozstd,
    this.toztyz,
    this.toztek,
    this.tozgrp,
    this.tozkek,
    this.tozkab,
    this.tozksk,
  });

  String stktip;
  String stkkod;
  String stkadi;
  dynamic stkad2;
  String stkokd;
  dynamic stkres;
  dynamic stkrrv;
  String stkbrm;
  String stkcns;
  String stktsk;
  double stktsu;
  String stktsb;
  String stkkac;
  dynamic stkgrp;
  dynamic stkag1;
  dynamic stkag2;
  dynamic stkbar;
  double stkrev;
  String stkrtr;
  double stkmin;
  dynamic stkmsm;
  double stkmfy;
  String stkmbr;
  String stkmtr;
  dynamic stkkdv;
  String stkrom;
  dynamic stkomr;
  dynamic stkocs;
  String stkskl;
  String stkizl;
  String stkcik;
  dynamic stkeni;
  dynamic stkenb;
  dynamic stkboy;
  dynamic stkbob;
  dynamic stkder;
  dynamic stkdeb;
  dynamic stkcap;
  dynamic stkcab;
  dynamic stkyog;
  dynamic stkgky;
  dynamic stkagr;
  String stksat;
  dynamic stknma;
  dynamic stknot;
  dynamic stkan1;
  dynamic stkan2;
  dynamic stkan3;
  dynamic stkan4;
  dynamic stkan5;
  dynamic stkln1;
  dynamic stkln2;
  dynamic stkln3;
  dynamic stkln4;
  dynamic stkln5;
  dynamic stkusr;
  dynamic stkcrt;
  String tozstp;
  String tozstk;
  String tozadi;
  String tozdeg;
  String tozstd;
  String toztyz;
  String toztek;
  dynamic tozgrp;
  dynamic tozkek;
  dynamic tozkab;
  dynamic tozksk;

  factory ProductDetayM.fromJson(Map<String, dynamic> json) => ProductDetayM(
        stktip: json["stktip"] == null ? null : json["stktip"],
        stkkod: json["stkkod"] == null ? null : json["stkkod"],
        stkadi: json["stkadi"] == null ? null : json["stkadi"],
        tozadi: json["tozadi"] == null ? null : json["tozadi"],
        tozdeg: json["tozdeg"] == null ? null : json["tozdeg"],
      );

  Map<String, dynamic> toJson() => {
        "stktip": stktip == null ? null : stktip,
        "stkkod": stkkod == null ? null : stkkod,
        "stkadi": stkadi == null ? null : stkadi,
        "stkad2": stkad2,
        "stkokd": stkokd == null ? null : stkokd,
        "stkres": stkres,
        "stkrrv": stkrrv,
        "stkbrm": stkbrm == null ? null : stkbrm,
        "stkcns": stkcns == null ? null : stkcns,
        "stktsk": stktsk == null ? null : stktsk,
        "stktsu": stktsu == null ? null : stktsu,
        "stktsb": stktsb == null ? null : stktsb,
        "stkkac": stkkac == null ? null : stkkac,
        "stkgrp": stkgrp,
        "stkag1": stkag1,
        "stkag2": stkag2,
        "stkbar": stkbar,
        "stkrev": stkrev == null ? null : stkrev,
        "stkrtr": stkrtr == null ? null : stkrtr,
        "stkmin": stkmin == null ? null : stkmin,
        "stkmsm": stkmsm,
        "stkmfy": stkmfy == null ? null : stkmfy,
        "stkmbr": stkmbr == null ? null : stkmbr,
        "stkmtr": stkmtr == null ? null : stkmtr,
        "stkkdv": stkkdv,
        "stkrom": stkrom == null ? null : stkrom,
        "stkomr": stkomr,
        "stkocs": stkocs,
        "stkskl": stkskl == null ? null : stkskl,
        "stkizl": stkizl == null ? null : stkizl,
        "stkcik": stkcik == null ? null : stkcik,
        "stkeni": stkeni,
        "stkenb": stkenb,
        "stkboy": stkboy,
        "stkbob": stkbob,
        "stkder": stkder,
        "stkdeb": stkdeb,
        "stkcap": stkcap,
        "stkcab": stkcab,
        "stkyog": stkyog,
        "stkgky": stkgky,
        "stkagr": stkagr,
        "stksat": stksat == null ? null : stksat,
        "stknma": stknma,
        "stknot": stknot,
        "stkan1": stkan1,
        "stkan2": stkan2,
        "stkan3": stkan3,
        "stkan4": stkan4,
        "stkan5": stkan5,
        "stkln1": stkln1,
        "stkln2": stkln2,
        "stkln3": stkln3,
        "stkln4": stkln4,
        "stkln5": stkln5,
        "stkusr": stkusr,
        "stkcrt": stkcrt,
        "tozstp": tozstp == null ? null : tozstp,
        "tozstk": tozstk == null ? null : tozstk,
        "tozadi": tozadi == null ? null : tozadi,
        "tozdeg": tozdeg == null ? null : tozdeg,
        "tozstd": tozstd == null ? null : tozstd,
        "toztyz": toztyz == null ? null : toztyz,
        "toztek": toztek == null ? null : toztek,
        "tozgrp": tozgrp,
        "tozkek": tozkek,
        "tozkab": tozkab,
        "tozksk": tozksk,
      };
}
