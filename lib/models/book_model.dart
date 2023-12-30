class Book {
  int? id;

  String? isbn;
  String? title;
  String? subtitle;
  String? author;
  String? published;
  String? publisher;
  int? pages;
  String? description;
  String? website;

  Book({
    this.id,
    this.isbn,
    this.title,
    this.subtitle,
    this.author,
    this.published,
    this.publisher,
    this.pages,
    this.description,
    this.website,
  });
  Book.from(Book book) {
    id = book.id;
    isbn = book.isbn;
    title = book.title;
    subtitle = book.subtitle;
    author = book.author;
    published = book.published;
    publisher = book.publisher;
    pages = book.pages;
    description = book.description;
    website = book.website;
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      isbn: json['isbn'],
      title: json['title'],
      subtitle: json['subtitle'],
      author: json['author'],
      published: json['published'],
      publisher: json['publisher'],
      pages: json['pages'],
      description: json['description'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isbn': isbn,
      'title': title,
      'subtitle': subtitle,
      'author': author,
      'published': published,
      'publisher': publisher,
      'pages': pages,
      'description': description,
      'website': website,
    };
  }
}
