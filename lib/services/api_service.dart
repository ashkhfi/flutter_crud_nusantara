import 'package:dio/dio.dart';

import '../constant/api.dart';
import '../models/book_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json));

  Future<Response> registerUser(Map<String, dynamic> userData) async {
    return await _dio.post(
      '$url/api/register',
      options: Options(headers: {'Accept': 'application/json'}),
      data: userData
    );
  }

  Future<Response> logout(String token) async {
    return await _dio.delete(
      '$url/api/user/logout',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> loginUser(Map<String, dynamic> loginData) async {
    return await _dio.post(
      '$url/api/login',
      options: Options(headers: {'Accept': 'application/json'}),
      data: loginData,
    );
  }

  Future<Response> getUserProfile(String token) async {
    return await _dio.get(
      '$url/api/user',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> fetchBooks(String token, int page, int perPage) async {
   return  await _dio.get(
        '$url/api/books',
        queryParameters: {
          'page': page,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
  }



  Future<Response> getBookDetail(int id, String token) async {
    return await _dio.get(
      '$url/api/books/$id',
      options: Options(headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
  }

  Future<Response> createBook(Book book, String token) async {
    return await _dio.post('$url/api/books/add',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
        data: book.toJson());
  }

  Future<Response> updateBook(int id, Book book, String token) async {
    return await _dio.put('$url/api/books/$id/edit',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
        data: book.toJson());
  }

  Future<Response> deleteBook(int id, String token) async {
    return await _dio.delete(
      '$url/api/books/$id',
      options: Options(headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
  }
}
