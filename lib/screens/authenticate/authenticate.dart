import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:library_management/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:library_management/screens/authenticate/signIn_admin.dart';
import 'package:library_management/services/connection.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(value: toggleView);
    } else {
      return SignInAsAdmin(value: toggleView);
    }
  }
}
