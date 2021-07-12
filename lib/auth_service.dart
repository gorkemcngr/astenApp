import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum KullaniciDurumu { OturumAcilmis, OturumAcilmamis, OturumAciliyor }
enum OturumAcma { yanlisPassword, dogruPassword }

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  KullaniciDurumu _durum = KullaniciDurumu.OturumAcilmamis;
  OturumAcma _oturum = OturumAcma.dogruPassword;
  KullaniciDurumu get durum => _durum;

  OturumAcma get oturum => _oturum;

  set oturum(OturumAcma value) {
    _oturum = value;
  }

  User _user;

  User get user => _user;

  set durum(KullaniciDurumu value) {
    _durum = value;
    notifyListeners();
  }

  AuthService() {
    _auth.authStateChanges().listen(_authStateChanged);
  }

  void _authStateChanged(User user) {
    if (user == null) {
      _user = null;
      durum = KullaniciDurumu.OturumAcilmamis;
    } else {
      _user = user;
      durum = KullaniciDurumu.OturumAcilmis;
    }
  }

  Future<User> createUserWithEmailandPassword(
      String email, String sifre) async {
    try {
      durum = KullaniciDurumu.OturumAciliyor;
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: sifre);
      User _yeniKullanici = _userCredential.user;
      _user = _yeniKullanici;
      return _yeniKullanici;
    } catch (e) {
      if (e.toString() ==
          "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {}
      durum = KullaniciDurumu.OturumAcilmamis;
      print("create user da hata çıktı : " + e.toString());
      return null;
    }
  }

  Future<User> signInUserWithEmailandPassword(
      String email, String sifre) async {
    try {
      durum = KullaniciDurumu.OturumAciliyor;
      UserCredential _userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: sifre);
      User _oturumAcanKullanici = _userCredential.user;
      _user = _oturumAcanKullanici;
      _oturum = OturumAcma.dogruPassword;
      return _oturumAcanKullanici;
    } catch (e) {
      if (e.toString() ==
              "[firebase_auth/wrong-password] The password is invalid or the user does not have a password." ||
          e.toString() ==
              "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
        _oturum = OturumAcma.yanlisPassword;
      }
      durum = KullaniciDurumu.OturumAcilmamis;
      print("sign in de hata çıktı : " + e.toString());
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      durum = KullaniciDurumu.OturumAcilmamis;
      _user = null;
      return true;
    } catch (e) {
      print("sign out da hata çıktı : " + e.toString());
    }
  }
}
