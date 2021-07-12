import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';

final formKey = GlobalKey<FormState>();

class KullaniciGiris extends StatelessWidget {
  KullaniciGiris({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    String user_email;
    String user_password;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                        child: Center(
                          child: Text(
                            "asten",
                            style: TextStyle(
                                fontSize: 70,
                                fontStyle: FontStyle.italic,
                                color: Colors.blueAccent),
                          ),
                        )),
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      user_email = value;
                    },
                    validator: (value) {
                      return validateEmail(value);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    onSaved: (value) {
                      user_password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                myAuth.oturum == OturumAcma.yanlisPassword
                    ? Text("Yanlış kullanıcı adı veya şifre",
                        style: TextStyle(color: Colors.red))
                    : SizedBox(),
                TextButton(
                  onPressed: () {
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        await myAuth.signInUserWithEmailandPassword(
                            user_email, user_password);
                        print(myAuth.oturum);
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                TextButton(
                  child: Text('New User? Create Account'),
                  onPressed: () {
                    kullaniciOlusturDialog(context, myAuth);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void kullaniciOlusturDialog(BuildContext context, myAuth) {
    var _formKey2 = GlobalKey<FormState>();
    String user_email;
    String user_password;

    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              Form(
                key: _formKey2,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close))),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Kayıt Ol",
                        style: TextStyle(fontSize: 26),
                      ),
                      margin: EdgeInsets.only(left: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          user_email = value;
                        },
                        validator: (value) {
                          return validateEmail(value);
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email Giriniz',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onSaved: (value) {
                          user_password = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Şifre',
                            hintText: 'Şifrenizi Giriniz',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey2.currentState.validate()) {
                            _formKey2.currentState.save();
                            await myAuth.createUserWithEmailandPassword(
                                user_email, user_password);
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Kayıt Ol"))
                  ],
                ),
              ),
            ],
          );
        });
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? "Lütfen Geçerli Bir email giriniz" : null;
  }
}
