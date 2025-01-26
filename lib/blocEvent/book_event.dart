import 'package:equatable/equatable.dart';
import 'package:book_library/models/books.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class FetchBooksByFaculty extends BookEvent {
  final BookFaculty faculty;

  const FetchBooksByFaculty(this.faculty);

  @override
  List<Object> get props => [faculty];
}

class AddBook extends BookEvent {
  final String title;
  final String author;
  final String description;
  final BookFaculty faculty;
  final String? imagePath;
  final String? pdfPath;

  const AddBook({
    required this.title,
    required this.author,
    required this.description,
    required this.faculty,
    this.imagePath,
    this.pdfPath,
  });

  @override
  List<Object> get props =>
      [title, author, description, faculty, imagePath ?? '', pdfPath ?? ''];
}
