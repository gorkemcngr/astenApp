import 'package:flutter/material.dart';
import 'package:flutter_asten_app/models/deliveries.dart';

import 'models/orders.dart';

class DeliveriesDetay extends StatefulWidget {
  Deliveries deliveries;

  DeliveriesDetay({this.deliveries});

  @override
  _DeliveriesDetayState createState() => _DeliveriesDetayState();
}

class _DeliveriesDetayState extends State<DeliveriesDetay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay Sayfası"),
      ),
      body: Container(
        margin: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: 'Firma Adı : ',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.deliveries.firadi,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                  text: 'Firma Kodu : ',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.deliveries.firkod,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                  text: 'Sed num: ',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.deliveries.sednum.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                  text: 'sevirs: ',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.deliveries.sevirs,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                  text: 'sevitr: ',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.deliveries.sevitr,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                  text: 'sevtad: ',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.deliveries.sevtad,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                  text: 'sipmyt: ',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.deliveries.sipmyt,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                  text: 'stpadi : ',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.deliveries.stpadi,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                  text: 'Tarih : ',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.deliveries.tarih.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Siparişler",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: widget.deliveries.detay.sipmik.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shadowColor: Colors.blue,
                              elevation: 4,
                              child: ListTile(
                                title:
                                    Text(widget.deliveries.detay.stkadi[index]),
                                subtitle: Text(
                                  "Stok Kodu : ${widget.deliveries.detay.stkkod[index]} \nSipariş Miktarı : ${widget.deliveries.detay.sipmik[index]} \nsedmik : ${widget.deliveries.detay.sedmik[index]} \nsipozl : ${widget.deliveries.detay.sipozl[index]} \nsippbr : ${widget.deliveries.detay.sppbr[index]} \nstkadi : ${widget.deliveries.detay.stkadi[index]} \nSipariş Tutarı : ${widget.deliveries.detay.siptut[index]}",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(7),
                          bottomRight: Radius.circular(7)),
                    ),
                    child: Text(
                      "  Toplam Tutar: ${toplamtutar()} ₺",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  toplamtutar() {
    double toplam = 0;
    for (int i = 0; i < widget.deliveries.detay.siptut.length; i++) {
      toplam = toplam + widget.deliveries.detay.siptut[i];
    }
    return toplam;
  }
}
