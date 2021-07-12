import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'locater.dart';
import 'main.dart';
import 'main_page.dart';

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 30, 101, 177),
          fontFamily: "Roboto-Regular"),
      home: SplashImage()));
} */

class SplashImage extends StatefulWidget {
  @override
  _SplashImageState createState() => _SplashImageState();
}

class _SplashImageState extends State<SplashImage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            image: DecorationImage(
                image: AssetImage("assets/asten-logo.png"),
                fit: BoxFit.contain)),
      ),
    );
  }
}
