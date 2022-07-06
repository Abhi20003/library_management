import 'package:library_management/screens/home/home_admin.dart';
import 'package:library_management/services/auth.dart';
import 'package:library_management/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:library_management/shared/loading.dart';
import 'package:library_management/services/connection.dart';

bool result = false;

class SignInAsAdmin extends StatefulWidget {
  final Function value;
  SignInAsAdmin({required this.value});

  @override
  State<SignInAsAdmin> createState() => _SignInAsAdminState();
}

class _SignInAsAdminState extends State<SignInAsAdmin> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String username = '';
  String pass = '';
  String err = '';

  @override
  Widget build(BuildContext context) {
    void func() {
      hasConnection().then((value) {
        setState(() {
          result = value; // Future is completed with a value.
        });
      });
    }

    func();

    if (result) {
      return loading
          ? Loading()
          : Scaffold(
              backgroundColor: Colors.blue[100],
              appBar: AppBar(
                backgroundColor: Colors.blue[400],
                elevation: 0.0,
                title: Text("SignIn as Administrator"),
                actions: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('SignIn with Google'),
                    onPressed: () {
                      widget.value();
                    },
                  )
                ],
              ),
              body: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: TextInputDecoration.copyWith(
                              hintText: 'Username'),
                          validator: (val) {
                            return val != null
                                ? null
                                : 'Enter a valid username';
                          },
                          onChanged: (val) {
                            setState(() {
                              username = val;
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: TextInputDecoration.copyWith(
                              hintText: 'Password'),
                          validator: (val) {
                            return val!.length < 6
                                ? 'Enter a password 6+ chars long'
                                : null;
                          },
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              pass = val;
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          color: Colors.pink,
                          child: Text(
                            'SignIn',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            setState(() {
                              loading = true;
                              print(username);
                              print(pass);
                            });
                            dynamic result =
                                await _auth.SignInAdmin(username, pass);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                err =
                                    'Could not sign in with those credentials';
                              });
                            }
                          },
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          err,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        )
                      ],
                    ),
                  )),
            );
    } else {
      return HomeAdmin();
    }
  }
}
