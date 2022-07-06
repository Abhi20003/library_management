import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_management/models/book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:library_management/models/book.dart';

class DatabaseService {
  DatabaseService();

  //collection reference
  final CollectionReference bookCollection =
      FirebaseFirestore.instance.collection('books');

  Future addBook(String title, String author, bool status, int id) async {
    return await bookCollection
        .doc(id.toString())
        .set({'title': title, 'author': author, 'status': status, 'id': id});
  }

  Future updateBook(String title, String author, bool status, int id) async {
    bookCollection
        .doc(id.toString())
        .update({'title': title, 'author': author, 'status': status, 'id': id});
  }

  Future deleteBook(int id) async {
    bookCollection.doc(id.toString()).delete();
  }

  //userData from snapshot
  Book _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Book(
      title: snapshot.get('title'),
      author: snapshot.get('author'),
      status: snapshot.get('status'),
      id: snapshot.get('id'),
    );
  }

  //book list from snapshot
  List<Book> _bookListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Book(
        title: doc.get('title') ?? "",
        author: doc.get('author') ?? "",
        status: doc.get('status') ?? "",
        id: doc.get('id'),
      );
    }).toList();
  }

  //get bruise stream
  Stream<List<Book>> get books {
    return bookCollection.snapshots().map(_bookListFromSnapshot);
  }

  Stream<Book> get userData {
    return bookCollection.doc().snapshots().map(_userDataFromSnapshot);
  }
}

class LocalDatabase {
  LocalDatabase();

  final _databaseName = "t102.db";
  final _databaseVersion = 1;

  final table = "BooksTable";

  String coltitle = "Title";
  String colAuthor = "Author";
  String colStatus = "Status";
  String colId = "Id";

  LocalDatabase._privateConstructor();
  static final LocalDatabase instance = LocalDatabase._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $colId INT PRIMARY KEY,
            $coltitle TEXT NOT NULL,
            $colAuthor TEXT NOT NULL,
            $colStatus INT NOT NULL
          )
          ''');
  }

  Future insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    await db.insert(table, row);
  }

  Future<List<Book>> queryAllRows() async {
    Database db = await instance.database;
    var allRows = await db.query(table);
    List<Book> books = List.filled(
        0, Book(title: "", author: "", status: false, id: 0),
        growable: true);
    allRows.forEach((result) {
      Book product = Book.fromMap(result);
      books.add(product);
    });
    return books;
  }

  Future<List> queryId() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT Id FROM $table');
  }

  Future<List> queryCount() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT COUNT(*) FROM $table');
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int name = row[colId];
    return await db.update(table, row, where: '$colId = ?', whereArgs: [name]);
  }

  Future<int> delete(int name) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$colId = ?', whereArgs: [name]);
  }
}
