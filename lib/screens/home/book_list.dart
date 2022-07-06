import 'package:flutter/material.dart';
import 'package:library_management/models/book.dart';
import 'package:library_management/screens/home/add_book.dart';
import 'package:library_management/services/connection.dart';
import 'package:library_management/services/database.dart';
import 'package:provider/provider.dart';
import 'package:library_management/screens/home/book_tile_user.dart';
import 'package:library_management/screens/home/book_tile_admin.dart';

int a = 1;
List l2 = [];
bool result = false;
List<Book> list = [];

class BookList extends StatefulWidget {
  final String endpoint;
  final String type;
  BookList({required this.endpoint, required this.type});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    var books = Provider.of<List<Book>>(context);

    final localdb = LocalDatabase.instance;
    void func1() {
      localdb.queryAllRows().then((value) {
        setState(() {
          list = value; // Future is completed with a value.
        });
      });
    }

    func1();

    void func() {
      hasConnection().then((value) {
        setState(() {
          result = value; // Future is completed with a value.
        });
      });
    }

    func();
    if (result) {
      books = Provider.of<List<Book>>(context);
      books.forEach((book) {
        if (list.contains(book)) {
        } else {
          list.add(book);
        }
      });
      // print(addpending);
      addpending.forEach((book) async {
        await DatabaseService()
            .addBook(book.title, book.author, book.status, book.id);
        print("done ${book.title}");
      });
      addpending = [];
      delpending.forEach((book) async {
        await DatabaseService().deleteBook(book.id);
      });
      delpending = [];
      // update pending
      updatepending.forEach((book) async {
        await DatabaseService()
            .updateBook(book.title, book.author, book.status, book.id);
      });
      updatepending = [];
    } else {
      books = list;
    }
    List<Book> availablebooks = [];
    List<Book> issuedbooks = [];
    books.forEach((book) {
      // print(book.status);
      if (!checkBool(book.status)) {
        availablebooks.add(book);
      } else {
        issuedbooks.add(book);
      }
    });

    if (widget.type == "All") {
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
    } else if (widget.type == "Issued") {
      return ListView.builder(
        itemCount: issuedbooks.length,
        itemBuilder: (context, index) {
          if (widget.endpoint == "Admin") {
            return BookTileAdmin(book: issuedbooks[index]);
          } else {
            return BookTileUser(book: issuedbooks[index]);
          }
        },
      );
    } else {
      return ListView.builder(
        itemCount: availablebooks.length,
        itemBuilder: (context, index) {
          if (widget.endpoint == "Admin") {
            return BookTileAdmin(book: availablebooks[index]);
          } else {
            return BookTileUser(book: availablebooks[index]);
          }
        },
      );
    }
  }
}
