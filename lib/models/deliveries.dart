class Deliveries {
  String firadi;
  String firkod;
  int sednum;
  String sevirs;
  String sevitr;
  String sevtad;
  String sipmyt;
  String stpadi;
  String tarih;
  DDetay detay;

  Deliveries(this.firadi, this.firkod, this.sednum, this.sevirs, this.sevitr,
      this.sevtad, this.sipmyt, this.stpadi, this.tarih, this.detay);

  @override
  String toString() {
    return 'Deliveries{firadi: $firadi, firkod: $firkod, sednum: $sednum, sevirs: $sevirs, sevitr: $sevitr, sevtad: $sevtad, sipmyt: $sipmyt, stpadi: $stpadi, tarih: $tarih, detay: $detay}';
  }
}

class DDetay {
  List<int> sedmik;
  List<int> sipmik;
  List<String> sipozl;
  List<String> sppbr;
  List<double> siptut;
  List<String> stkadi;
  List<String> stkkod;

  DDetay.fromMap(Map<String, dynamic> map) {
    this.sedmik = List.from(map["sedmik"]);
    this.sipmik = List.from(map["sipmik"]);
    this.sipozl = List.from(map["sipozl"]);
    this.sppbr = List.from(map["sippbr"]);
    this.siptut = List.from(map["siptut"]);
    this.stkadi = List.from(map["stkadi"]);
    this.stkkod = List.from(map["stkkod"]);
  }
}
