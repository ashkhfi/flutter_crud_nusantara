import 'package:flutter_crud_nusantara/models/book_response_model.dart';
import 'package:flutter_crud_nusantara/services/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/book_model.dart';

class BookController extends GetxController {
  final ApiService _bookService = ApiService();
  RxList<Book> books = <Book>[].obs;
  RxList<BookResponse> booksResponse = <BookResponse>[].obs;
  final RxBool isChangePage = false.obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxInt totalData = 1.obs;

  @override
  void onInit() {
    fetchBooks();
    super.onInit();
  }

  Future<void> fetchBooks() async {
    try {
      String? token = await _getToken();
      final response =
          await _bookService.fetchBooks(token!, currentPage.value, 5);

      if (response.statusCode == 200) {
        final data = response.data;
        final List<Book> fetchedBooks =
            List<Book>.from(data['data'].map((book) => Book.fromJson(book)));
        books.assignAll(fetchedBooks);
        currentPage.value = data['current_page'];
        totalPages.value = data['last_page'];
        totalData.value = data['total'];
      } else {
        print('Error fetching books: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching books: $error');
    }
  }

  Future<void> createBook(Book book) async {
    try {
      String? token = await _getToken();
      final response = await _bookService.createBook(book, token!);
      if (response.statusCode == 200) {
        fetchBooks();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateBook(int id, Book book) async {
    try {
      String? token = await _getToken();
      final response = await _bookService.updateBook(id, book, token!);
      if (response.statusCode == 200) {
        fetchBooks();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteBook(int id) async {
    try {
      String? token = await _getToken();
      final response = await _bookService.deleteBook(id, token!);
      if (response.statusCode == 200) {
        fetchBooks();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<Book> getBookDetail(int id) async {
    try {
      String? token = await _getToken();
      final response = await _bookService.getBookDetail(id, token!);

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = response.data;
        if (data != null) {
          final Book book = Book.fromJson(data);
          return book;
        } else {
          throw Exception('Response data or data["data"] is null');
        }
      } else {
        throw Exception('Failed to get book details');
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> loadNextPage() async {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      await fetchBooks();
    }
  }

  Future<void> loadPrevPage() async {
    if (currentPage.value > 1) {
      currentPage.value--;
      await fetchBooks();
    }
  }
}
