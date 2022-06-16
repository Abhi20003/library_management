import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:library_management/models/book.dart';
import 'package:library_management/screens/home/book_list.dart';
import 'package:library_management/services/database.dart';
import 'package:library_management/shared/showpanel.dart';

class BookTile extends StatefulWidget {
  final Book? book;
  BookTile({required this.book});

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
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
          trailing: FlatButton.icon(
              onPressed: () => showEditBookPanel(context, widget.book!.title,
                  widget.book!.author, widget.book!.status),
              icon: Icon(Icons.settings),
              label: Text("Edit")),
        ),
      ),
    );
  }
}

// class BookTile extends StatelessWidget {
//   final Book book;
//   BookTile({required this.book});
//   bool? value = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 8.0),
//       child: Card(
//         margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//         child: ListTile(
//           leading: Checkbox(
//             value: this.value,
//             onChanged: ((value) {
//               setState(() {});
//               book.status == "1" ? book.status = "0" : book.status = "1";
//               this.value = value;
//             }),
//           ),
//           title: Text(book.title),
//           subtitle: Text(book.author),
//         ),
//       ),
//     );
//   }
// }
