import 'package:flutter/material.dart';

import 'models/orders.dart';

class OrderDetay extends StatefulWidget {
  Orders order;

  OrderDetay({this.order});

  @override
  _OrderDetayState createState() => _OrderDetayState();
}

class _OrderDetayState extends State<OrderDetay> {
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
                      text: widget.order.firadi,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(
              height: 10,
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
                      text: widget.order.firkod,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                  text: 'Sipariş Numarası : ',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.order.sipnum.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            SizedBox(
              height: 10,
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
                      text: widget.order.tarih.toString(),
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
                          itemCount: widget.order.detay.sipmik.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shadowColor: Colors.blue,
                              elevation: 4,
                              child: ListTile(
                                title: Text(widget.order.detay.stkadi[index]),
                                subtitle: Text(
                                  "Stok Kodu : ${widget.order.detay.stkkod[index]} \nSipariş Miktarı : ${widget.order.detay.sipmik[index]} \nSipariş Tutarı : ${widget.order.detay.siptut[index]}",
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
    for (int i = 0; i < widget.order.detay.siptut.length; i++) {
      toplam = toplam + widget.order.detay.siptut[i];
    }
    return toplam;
  }
}
