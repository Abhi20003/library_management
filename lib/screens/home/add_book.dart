import 'package:library_management/models/book.dart';
import 'package:library_management/models/user.dart';
import 'package:library_management/services/connection.dart';
import 'package:library_management/services/database.dart';
import 'package:flutter/material.dart';
import 'package:library_management/shared/constants.dart';
import 'package:provider/provider.dart';
import 'dart:math';

List haveIt = [];
List list = [];
List<Book> addpending = [];
int RandomNumber() {
  Random random = new Random();
  int id = random.nextInt(100000000);
  if (haveIt.contains(id)) {
    RandomNumber();
  } else {
    haveIt.add(id);
  }
  return id;
}

class AddBook extends StatefulWidget {
  AddBook();

  @override
  State<AddBook> createState() => _AddBook();
}

class _AddBook extends State<AddBook> {
  final _formkey = GlobalKey<FormState>();
  final localdb = LocalDatabase.instance;

  //form values
  String? _currentTitle;
  String? _currentAuthor;
  int id = RandomNumber();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userdet?>(context);
    return Form(
      key: _formkey,
      child: Column(children: <Widget>[
        Text(
          "Add Book Details",
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 20.0),
        TextFormField(
          initialValue: "",
          decoration: TextInputDecoration.copyWith(hintText: 'Title'),
          validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
          onChanged: (val) => setState(() => _currentTitle = val),
        ),
        SizedBox(height: 20.0),
        //dropdown
        TextFormField(
            initialValue: "",
            decoration: TextInputDecoration.copyWith(hintText: 'Author'),
            onChanged: (val) => setState(() => _currentAuthor = val)),
        SizedBox(height: 20.0),
        RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Add Book',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                print(_currentTitle);
                if (await hasConnection()) {
                  await DatabaseService().addBook(
                    _currentTitle ?? "",
                    _currentAuthor ?? "",
                    0,
                    id,
                  );
                } else {
                  addpending.add(Book(
                      title: _currentTitle!,
                      author: _currentAuthor!,
                      status: 0,
                      id: id));
                }
                // print(addpending);
                Map<String, dynamic> row = {
                  LocalDatabase().coltitle: _currentTitle,
                  LocalDatabase().colAuthor: _currentAuthor,
                  LocalDatabase().colStatus: 0,
                  LocalDatabase().colId: id,
                };
                localdb.insert(row);
                Navigator.pop(context);
              }
            })
      ]),
    );
  }
}
