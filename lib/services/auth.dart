import 'package:flutter/services.dart';
import 'package:library_management/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //create user object based on FirebaseUser
  Userdet? _userFromFirebaseUser(User? user) {
    return user != null ? Userdet(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Userdet?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email/password
  Future SignInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }

//sign in for admin
  Future<dynamic> SignInAdmin(username, password) async {
    User? user1 = null;
    final response = await http.post(
      Uri.parse('https://sids438.pythonanywhere.com/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      String val = jsonDecode(response.body);
      print(val);
      if (val == 'Logged In') {
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: "sutt_admin@gmail.com", password: "1234567890");
        User? user = result.user;
        return _userFromFirebaseUser(user);
      } else {
        print("Im here");
        return _userFromFirebaseUser(user1);
      }
    } else {
      print("blaablaa");
      return _userFromFirebaseUser(user1);
    }
  }

  //sign out
  Future signOut() async {
    try {
      googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future SignInWithGoogle() async {
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await _auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        try {
          UserCredential result = await _auth.signInWithCredential(credential);
          User? user = result.user;
          return _userFromFirebaseUser(user);
        } on PlatformException catch (e) {
          print("Error ${e.toString()}");
          SignInWithGoogle();
        }
      }
    }
  }
}
