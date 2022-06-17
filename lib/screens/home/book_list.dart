import 'package:flutter/material.dart';
import 'package:library_management/models/book.dart';
import 'package:provider/provider.dart';
import 'package:library_management/screens/home/book_tile_user.dart';
import 'package:library_management/screens/home/book_tile_admin.dart';

class BookList extends StatefulWidget {
  String endpoint;
  BookList({required this.endpoint});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    final books = Provider.of<List<Book>>(context);
    books.forEach((book) {
      // print(book.title);
      // print(book.author);
      // print(book.status);
    });

    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        if (widget.endpoint == "Admin") {
          return BookTileAdmin(book: books[index]);
        } else {
          return BookTileUser(book: books[index]);
        }
      },
    );
  }
}
