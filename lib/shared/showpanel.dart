import 'package:flutter/material.dart';
import 'package:library_management/screens/home/book_tile.dart';
import 'package:library_management/screens/home/add_book.dart';
import 'package:library_management/screens/home/update_book.dart';

void showAddBookPanel(context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: AddBook(),
        );
      });
}

void showEditBookPanel(context, String title, String author, bool status) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: UpdateBook(
            title: title,
            author: author,
            status: status,
          ),
        );
      });
}
