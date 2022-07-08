import 'package:flutter/material.dart';
import 'package:library_management/models/book.dart';
import 'package:library_management/services/connection.dart';
import 'package:library_management/services/database.dart';
import 'package:library_management/shared/showpanel.dart';

List<Book> delpending = [];
List<Book> updatepending = [];
bool result = false;

bool checkBool(var temp) {
  // print(temp);
  if (temp == 0) {
    return false;
  } else {
    return true;
  }
}

class BookTileAdmin extends StatefulWidget {
  final Book? book;
  BookTileAdmin({required this.book});

  @override
  State<BookTileAdmin> createState() => _BookTileAdminState();
}

class _BookTileAdminState extends State<BookTileAdmin> {
  bool? value;

  LocalDatabase localdb = LocalDatabase.instance;

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
    // print(widget.book!.status);

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
                widget.book!.status = checkBool(widget.book!.status) ? 0 : 1;
                if (result) {
                  DatabaseService().updateBook(
                      widget.book!.title,
                      widget.book!.author,
                      widget.book!.status,
                      widget.book!.id);
                } else {
                  updatepending.add(Book(
                      title: widget.book!.title,
                      author: widget.book!.author,
                      status: widget.book!.status,
                      id: widget.book!.id));
                }
                Map<String, dynamic> row = {
                  LocalDatabase().coltitle: widget.book!.title,
                  LocalDatabase().colAuthor: widget.book!.author,
                  LocalDatabase().colStatus: widget.book!.status,
                  LocalDatabase().colId: widget.book!.id,
                };
                localdb.update(row);
              });
            }),
          ),
          title: Text(widget.book!.title),
          subtitle: Text("${widget.book!.author}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => showEditBookPanel(context, widget.book!.title,
                    widget.book!.author, widget.book!.status, widget.book!.id),
                icon: Icon(Icons.settings),
              ),
              IconButton(
                  onPressed: () {
                    if (result) {
                      DatabaseService().deleteBook(widget.book!.id);
                    } else {
                      delpending.add(Book(
                          title: widget.book!.title,
                          author: widget.book!.author,
                          status: widget.book!.status,
                          id: widget.book!.id));
                    }
                    // print(delpending);
                    LocalDatabase().delete(widget.book!.id);
                  },
                  icon: Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
