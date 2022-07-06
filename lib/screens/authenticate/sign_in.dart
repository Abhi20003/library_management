import 'package:library_management/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:library_management/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function value;
  SignIn({required this.value});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  // final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state

  String err = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              title: Text("SignIn to the Library"),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 250.0,
                    height: 50.0,
                    child: RaisedButton.icon(
                        label: Text(
                          "SignIn with Google",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                        ),
                        icon: ImageIcon(AssetImage("assets/google.png")),
                        color: Colors.white,
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          await _auth.SignInWithGoogle();
                        }),
                  ),
                  SizedBox(height: 12.0),
                  SizedBox(
                    width: 250.0,
                    height: 50.0,
                    child: RaisedButton.icon(
                        label: Text(
                          "SignIn as Administrator",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                        ),
                        icon: Icon(Icons.person),
                        color: Colors.white,
                        onPressed: () async {
                          widget.value();
                        }),
                  ),
                  Text(
                    err,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    ),
                  )
                ],
              ),
            ));
  }
}
