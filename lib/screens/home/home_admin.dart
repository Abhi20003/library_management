import 'package:library_management/services/auth.dart';
import 'package:library_management/models/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:library_management/services/database.dart';

class HomeAdmin extends StatefulWidget {
  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // final books = Provider.of<List<Book>>(context);
    // final localdb = LocalDatabase.instance;
    // books.forEach((book) {
    //   Map<String, dynamic> row = {
    //     LocalDatabase().coltitle: book.title,
    //     LocalDatabase().colAuthor: book.author,
    //     LocalDatabase().colStatus: book.status,
    //   };
    //   localdb.insert(row);
    // });
    // var data = localdb.queryAllRows();
    // convertFutureListToList(data);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
          backgroundColor: Colors.blue[400],
          title: Text("Admin Home"),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text("Logout"))
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
                    Navigator.pushNamed(context, '/listAdminBooks',
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
                    Navigator.pushNamed(context, '/listAdminBooks',
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
                    Navigator.pushNamed(context, '/listAdminBooks',
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
