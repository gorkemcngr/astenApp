class Orders {
  String firadi;
  String firkod;
  int sipnum;
  String tarih;
  Detay detay;

  Orders(this.firadi, this.firkod, this.sipnum, this.tarih, this.detay);

  @override
  String toString() {
    return 'Orders{firadi: $firadi, firkod: $firkod, sipnum: $sipnum, tarih: $tarih, detay: $detay}';
  }
}

class Detay {
  List<int> sipmik;
  List<double> siptut;
  List<String> stkadi;
  List<String> stkkod;

  Detay.fromMap(Map<String, dynamic> map) {
    this.sipmik = List.from(map["sipmik"]);
    this.siptut = List.from(map["siptut"]);
    this.stkadi = List.from(map["stkadi"]);
    this.stkkod = List.from(map["stkkod"]);
  }
}
