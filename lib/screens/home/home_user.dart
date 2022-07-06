import 'package:library_management/services/auth.dart';
import 'package:library_management/models/book.dart';
import 'package:flutter/material.dart';
import 'package:library_management/services/database.dart';

class HomeUser extends StatefulWidget {
  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
          backgroundColor: Colors.blue[400],
          title: Text("User Home"),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Logout"),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ]),
      body: SizedBox(
        height: 500.0,
        width: 350.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, top: 100.0),
          child: ListView(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  title: Text(
                    "All Books",
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/listUserBooks',
                        arguments: BookType(type: "All"));
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  title: Text(
                    "Issued Books",
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/listUserBooks',
                        arguments: BookType(type: "Issued"));
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  title: Text(
                    "Available Books",
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/listUserBooks',
                        arguments: BookType(type: "Available"));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
