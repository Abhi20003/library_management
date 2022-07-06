import 'package:flutter/material.dart';

class Userdet {
  final String? uid;

  Userdet({this.uid});
}

// class UserData {
//   late String title;
//   late String author;
//   late bool status;
//   late String uid;

//   UserData(
//       {required this.title,
//       required this.author,
//       required this.status,
//       required this.uid});
// }

class Request {
  final String username;
  final String password;

  const Request({required this.username, required this.password});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      username: json['username'],
      password: json['password'],
    );
  }
}
