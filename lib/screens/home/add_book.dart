import 'package:library_management/models/user.dart';
import 'package:library_management/services/database.dart';
import 'package:library_management/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:library_management/shared/constants.dart';
import 'package:provider/provider.dart';

class AddBook extends StatefulWidget {
  AddBook();

  @override
  State<AddBook> createState() => _AddBook();
}

class _AddBook extends State<AddBook> {
  final _formkey = GlobalKey<FormState>();

  //form values
  String? _currentTitle;
  String? _currentAuthor;

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
        // TextFormField(
        //     initialValue: "",
        //     decoration: TextInputDecoration.copyWith(hintText: 'Status'),
        //     onChanged: (val) => setState(() => _currentstatus = val)),
        RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                await DatabaseService().addBook(
                  _currentTitle ?? "",
                  _currentAuthor ?? "",
                  false,
                );
                Navigator.pop(context);
              }
            })
      ]),
    );
  }
}
