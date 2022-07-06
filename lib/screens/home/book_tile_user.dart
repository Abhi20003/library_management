import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:library_management/models/book.dart';
import 'package:library_management/screens/home/book_list.dart';
import 'package:library_management/services/database.dart';
import 'package:library_management/shared/showpanel.dart';
import 'package:library_management/services/connection.dart';
import 'package:library_management/screens/home/book_tile_admin.dart';

bool result = false;

class BookTileUser extends StatefulWidget {
  final Book? book;
  BookTileUser({required this.book});

  @override
  State<BookTileUser> createState() => _BookTileUserState();
}

class _BookTileUserState extends State<BookTileUser> {
  LocalDatabase localdb = LocalDatabase.instance;

  bool? value;
  @override
  Widget build(BuildContext context) {
    void func() {
      hasConnection().then((t1) {
        setState(() {
          result = t1; // Future is completed with a value.
        });
      });
    }

    func();
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Checkbox(
            value: checkBool(widget.book!.status),
            onChanged: ((value) {
              setState(() {
                print(value);
                widget.book!.status = !checkBool(widget.book!.status);
                if (result) {
                  DatabaseService().updateBook(
                      widget.book!.title,
                      widget.book!.author,
                      checkBool(widget.book!.status),
                      widget.book!.id);
                } else {
                  updatepending.add(Book(
                      title: widget.book!.title,
                      author: widget.book!.author,
                      status: checkBool(widget.book!.status),
                      id: widget.book!.id));
                }
                Map<String, dynamic> row = {
                  LocalDatabase().coltitle: widget.book!.title,
                  LocalDatabase().colAuthor: widget.book!.author,
                  LocalDatabase().colStatus:
                      checkBool(widget.book!.status) ? 1 : 0,
                  LocalDatabase().colId: widget.book!.id,
                };
                localdb.update(row);
              });
              print(widget.book!.status);
            }),
          ),
          title: Text(widget.book!.title),
          subtitle: Text("${widget.book!.author}"),
        ),
      ),
    );
  }
}
