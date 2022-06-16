import 'package:library_management/models/user.dart';
import 'package:library_management/services/database.dart';
import 'package:library_management/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:library_management/shared/constants.dart';
import 'package:provider/provider.dart';

class UpdateBook extends StatefulWidget {
  String title;
  String author;
  bool status;

  UpdateBook({required this.title, required this.author, required this.status});

  @override
  State<UpdateBook> createState() => _UpdateBook();
}

class _UpdateBook extends State<UpdateBook> {
  final _formkey = GlobalKey<FormState>();

  //form values
  dynamic _currentTitle;
  dynamic _currentAuthor;
  dynamic _currentStatus;

  @override
  Widget build(BuildContext context) {
    _currentAuthor = widget.author;
    _currentStatus = widget.status;
    _currentTitle = widget.title;
    final user = Provider.of<Userdet?>(context);
    return Form(
      key: _formkey,
      child: Column(children: <Widget>[
        Text(
          "Update Book Details (Author)",
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 20.0),
        Text(
          "Book:   ${_currentTitle}",
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 20.0),
        TextFormField(
            initialValue: "",
            autofocus: false,
            decoration: TextInputDecoration.copyWith(hintText: 'Author'),
            onChanged: (val) => setState(() {
                  _currentAuthor = val;
                })),
        SizedBox(height: 20.0),
        RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                print(_currentAuthor);
                await DatabaseService().updateBook(
                  _currentTitle ?? "",
                  _currentAuthor ?? "",
                  _currentStatus ?? false,
                );

                Navigator.pop(context);
              }
            })
      ]),
    );
  }
}
