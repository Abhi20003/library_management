import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:library_management/models/book.dart';
import 'package:library_management/screens/home/book_list.dart';
import 'package:library_management/services/database.dart';
import 'package:library_management/shared/showpanel.dart';

class BookTileAdmin extends StatefulWidget {
  final Book? book;
  BookTileAdmin({required this.book});

  @override
  State<BookTileAdmin> createState() => _BookTileAdminState();
}

class _BookTileAdminState extends State<BookTileAdmin> {
  bool? value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Checkbox(
            value: widget.book!.status,
            onChanged: ((value) {
              setState(() {
                print(value);
                widget.book!.status = !widget.book!.status;
                DatabaseService().updateBook(widget.book!.title,
                    widget.book!.author, widget.book!.status);
              });
              print(widget.book!.status);
            }),
          ),
          title: Text(widget.book!.title),
          subtitle: Text("${widget.book!.author}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => showEditBookPanel(context, widget.book!.title,
                    widget.book!.author, widget.book!.status),
                icon: Icon(Icons.settings),
              ),
              IconButton(
                  onPressed: () =>
                      DatabaseService().deleteBook(widget.book!.title),
                  icon: Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
