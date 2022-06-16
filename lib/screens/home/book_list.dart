import 'package:flutter/material.dart';
import 'package:library_management/models/book.dart';
import 'package:provider/provider.dart';
import 'package:library_management/screens/home/book_tile.dart';

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

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
        return BookTile(book: books[index]);
      },
    );
  }
}
