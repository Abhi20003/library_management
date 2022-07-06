// import 'package:library_management/models/book.dart';
// import 'package:library_management/services/connection.dart';
// import 'package:library_management/services/database.dart';

// bool result = false;

// class sendDatatoFirestore {
//   void sendAddData(List<Book> addpending) async {
//     await hasConnection();
//     if (result) {
//       addpending.forEach((book) async {
//         await DatabaseService()
//             .addBook(book.title, book.author, book.status, book.id);
//       });
//     }
//   }

//   void sendUpdateData(List<Book> updatepending) async {
//     await hasConnection();
//     if (result) {
//       updatepending.forEach((book) async {
//         await DatabaseService()
//             .updateBook(book.title, book.author, book.status, book.id);
//       });
//     }
//   }

//   void sendDelData(List<Book> delpending) async {
//     await hasConnection();
//     if (result) {
//       delpending.forEach((book) async {
//         await DatabaseService().deleteBook(book.id);
//       });
//     }
//   }

//   // void _convert(Future<bool> temp) async {
//   //   result = await temp;
//   // }
// }
