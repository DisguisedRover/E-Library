import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/books.dart';
import '../models/review.dart';

class ApiService {
  static const String baseUrl = '192.168.18.90:5000';
  static const String baseApiUrl = 'http://$baseUrl/books';

  static String getFullUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return 'http://$baseUrl/uploads/${path.split('/').last}'
        .replaceAll('\\', '/');
  }

  Future<List<Book>> getBooksByFaculty(String faculty) async {
    final url = Uri.parse(baseApiUrl)
        .replace(queryParameters: {'faculty': faculty.toLowerCase()});
    print('Fetching books from: $url');
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Book.fromJson(json)).toList();
      } else {
        throw ApiException(
            'Failed to load books. Status code: ${response.statusCode}',
            response.statusCode);
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      rethrow;
    } on SocketException catch (e) {
      print('Socket Exception: $e');
      rethrow;
    } catch (e) {
      print('Error fetching books: $e');
      rethrow;
    }
  }

  Future<Book> addBook({
    required String title,
    required String author,
    required String description,
    required String faculty,
    File? pdfFile,
    File? coverImage,
  }) async {
    try {
      var uri = Uri.parse(baseApiUrl);
      var request = http.MultipartRequest('POST', uri);

      // Add text fields
      request.fields['title'] = title;
      request.fields['author'] = author;
      request.fields['description'] = description;
      request.fields['faculty'] = faculty;

      // Add PDF file if exists
      if (pdfFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'pdf_Path',
          pdfFile.path,
        ));
      }

      // Add cover image if exists
      if (coverImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'imagePath',
          coverImage.path,
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        return Book.fromJson(json.decode(response.body));
      } else {
        throw ApiException('Failed to add book', response.statusCode);
      }
    } catch (e) {
      print('Error uploading book: $e');
      rethrow;
    }
  }

  Future<List<Review>> getReviews(int bookId) async {
    final response = await http.get(Uri.parse('$baseApiUrl/$bookId/reviews'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((review) => Review.fromJson(review)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<Review> addReview(
      int bookId, String reviewer, String comment, int rating) async {
    final response = await http.post(
      Uri.parse('$baseApiUrl/$bookId/review'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'reviewer': reviewer, 'comment': comment, 'rating': rating}),
    );
    if (response.statusCode == 201) {
      return Review.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() {
    return 'ApiException: $message${statusCode != null ? ' (Status Code: $statusCode)' : ''}';
  }
}
