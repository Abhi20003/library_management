import 'package:library_management/services/auth.dart';
import 'package:library_management/models/book.dart';
import 'package:flutter/material.dart';
import 'package:library_management/services/database.dart';
import 'package:provider/provider.dart';
import 'package:library_management/screens/home/book_list.dart';
import 'package:library_management/shared/showpanel.dart';

class ListAdminBooks extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BookType;
    return StreamProvider<List<Book>?>.value(
      initialData: List.empty(),
      value: DatabaseService().books,
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          title: Text(
            "Book Catalogue",
            style: TextStyle(fontSize: 17.0),
          ),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Book'),
              onPressed: () => showAddBookPanel(context),
            )
          ],
        ),
        body: Container(
            child: BookList(
          endpoint: "Admin",
          type: args.type,
        )),
      ),
    );
  }
}
