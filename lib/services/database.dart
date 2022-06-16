import 'package:library_management/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_management/models/book.dart';

class DatabaseService {
  DatabaseService();

  //collection reference
  final CollectionReference bookCollection =
      FirebaseFirestore.instance.collection('books');

  Future addBook(String title, String author, bool status) async {
    return await bookCollection
        .doc(title)
        .set({'title': title, 'author': author, 'status': status});
  }

  Future updateBook(String title, String author, bool status) async {
    bookCollection
        .doc(title)
        .update({'title': title, 'author': author, 'status': status});
  }

  //book list from snapshot
  List<Book> _bookListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Book(
        title: doc.get('title') ?? "",
        author: doc.get('author') ?? "",
        status: doc.get('status') ?? "",
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      title: snapshot.get('title'),
      author: snapshot.get('author'),
      status: snapshot.get('status'),
      uid: snapshot.get('uid'),
    );
  }

  //get bruise stream

  Stream<List<Book>> get books {
    return bookCollection.snapshots().map(_bookListFromSnapshot);
  }

  // get user doc stream

  Stream<UserData> get userData {
    return bookCollection.doc().snapshots().map(_userDataFromSnapshot);
  }
}
