import 'book_model.dart';

class BookResponse {
  late int currentPage;
  late List<Book> data;
  late String firstPageUrl;
  late int? from;
  late int lastPage;
  late String lastPageUrl;
  late String? nextPageUrl;
  late String path;
  late int perPage;
  late String? prevPageUrl;
  late int? to;
  late int total;

  BookResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = List<Book>.from(json['data'].map((book) => Book.fromJson(book)));
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}