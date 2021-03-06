class Book {
  final String title;
  final String author;
  int status;
  final int id;

  Book(
      {required this.title,
      required this.author,
      required this.status,
      required this.id});

  factory Book.fromMap(Map<String, dynamic> data) {
    return Book(
      title: data['Title'],
      author: data['Author'],
      status: data['Status'],
      id: data['Id'],
    );
  }
}

class BookType {
  final String type;
  BookType({required this.type});
}
