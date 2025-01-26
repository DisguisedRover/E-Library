import 'package:book_library/services/api_service.dart';

class Book {
  final int id;
  final String title;
  final BookFaculty faculty;
  final String imagepath;
  final String description;
  final String? pdfPath;
  final String? author;

  const Book({
    required this.id,
    required this.title,
    required this.faculty,
    required this.imagepath,
    required this.description,
    this.pdfPath,
    this.author,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    // Print debugging information
    print('Received JSON: $json');

    try {
      return Book(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        faculty: _getFacultyFromString(json['faculty']),
        author: json['author'],
        description: json['description'] ?? '',
        imagepath: ApiService.getFullUrl(json[
            'imagePath']), // Use imagePath instead of imagepath to match backend
        pdfPath: ApiService.getFullUrl(json['pdf_Path']),
      );
    } catch (e) {
      print('Error parsing JSON: $e');
      rethrow;
    }
  }

  static BookFaculty _getFacultyFromString(dynamic facultyValue) {
    if (facultyValue == null) return BookFaculty.BIM;

    String facultyStr = facultyValue.toString().toUpperCase();
    switch (facultyStr) {
      case 'BHM':
        return BookFaculty.BHM;
      case 'BIM':
      default:
        return BookFaculty.BIM;
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'faculty': faculty.toString().split('.').last,
        'author': author,
        'description': description,
        'imagePath': imagepath,
        'pdf_Path': pdfPath,
      };
}

enum BookFaculty {
  BIM,
  BHM;

  String get displayName {
    switch (this) {
      case BookFaculty.BIM:
        return "Bachelor in Information Management";
      case BookFaculty.BHM:
        return "Bachelor in Hotel Management";
    }
  }
}
