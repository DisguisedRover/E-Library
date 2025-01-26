/*import 'package:flutter/material.dart';
import 'package:book_library/models/books.dart';

/// Singleton class for managing the book library.
class Library extends ChangeNotifier {
  // Private constructor for singleton
  Library._internal();

  // Singleton instance
  static final Library _instance = Library._internal();

  // Factory constructor
  factory Library() => _instance;

  // Internal book list
  final List<Book> _books = [
    const Book(
      title: 'Object-Oriented Programming',
      faculty: BookFaculty.BIM,
      imagepath: 'lib/images/OOP.jpg',
      description: 'Learn about object-oriented programming concepts.',
      pdfPath: 'lib/assets/OOP.pdf',
    ),
    const Book(
      title: 'Data Structures',
      faculty: BookFaculty.BIM,
      imagepath: 'lib/images/DS.webp',
      description:
          ' Introduces efficient ways of organizing and processing data using various algorithms and their applications in problem-solving.',
      pdfPath: 'lib/assets/Dsa.pdf',
    ),

    const Book(
      title: 'Database Management System',
      faculty: BookFaculty.BIM,
      imagepath: 'lib/images/DBMS.jpg',
      description:
          'Teaches database design, querying, and management, focusing on SQL and relational database systems.',
      pdfPath: 'lib/assets/DBMS.pdf',
    ),
    const Book(
      title: ' Software Engineering',
      faculty: BookFaculty.BIM,
      imagepath: 'lib/images/SE.jpg',
      description:
          'Focuses on the principles of software development life cycles, project management, and quality assurance.',
      pdfPath: 'lib/assets/SE.pdf',
    ),
    const Book(
      title: 'System Analysis and Design',
      faculty: BookFaculty.BIM,
      imagepath: 'lib/images/SAD.jpg',
      description:
          'Explores methods for analyzing and designing information systems to meet organizational needs.',
      pdfPath: 'lib/assets/SAD.pdf',
    ),
    const Book(
      title: 'Artificial Intelligence',
      faculty: BookFaculty.BIM,
      imagepath: 'lib/images/AI.jpg',
      description:
          ' Introduces concepts of AI, machine learning, natural language processing, and robotics.',
      pdfPath: 'lib/assets/AI.pdfPath',
    ),
    //BHM books
    const Book(
      title: 'Introduction to Hospitality and Tourism',
      faculty: BookFaculty.BHM,
      imagepath: 'assets/images/oop.png',
      description:
          'Provides an overview of the hospitality and tourism industry, its structure, and career opportunities.',
      pdfPath: '',
    ),
    const Book(
      title: 'Food and Beverage Production',
      faculty: BookFaculty.BHM,
      imagepath: 'assets/images/oop.png',
      description:
          'Focuses on culinary skills, kitchen operations, and techniques for preparing and presenting food.',
      pdfPath: '',
    ),
    const Book(
      title: 'Front Office Management',
      faculty: BookFaculty.BHM,
      imagepath: 'assets/images/oop.png',
      description:
          'Covers the operations of the hotel front office, including reservations, check-ins, check-outs, and guest services.',
      pdfPath: '',
    ),
    const Book(
      title: 'Housekeeping Management',
      faculty: BookFaculty.BHM,
      imagepath: 'assets/images/oop.png',
      description:
          'Focuses on maintaining cleanliness, ambiance, and comfort in guest rooms and public areas of hotels.',
      pdfPath: '',
    ),

    const Book(
      title: 'Principles of Management',
      faculty: BookFaculty.BHM,
      imagepath: 'assets/images/oop.png',
      description:
          'Introduces fundamental management principles, focusing on planning, organizing, staffing, and controlling within a hospitality context.',
      pdfPath: '',
    ),
    const Book(
      title: 'Hospitality Accounting',
      faculty: BookFaculty.BHM,
      imagepath: 'assets/images/oop.png',
      description:
          ' Teaches financial management and accounting concepts specific to the hospitality industry.',
      pdfPath: '',
    ),
  ];

  /// Read-only access to the list of books.
  List<Book> get books => List.unmodifiable(_books);

  /// Adds a new book to the library.
  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }

  /// Removes a book from the library.
  void removeBook(Book book) {
    _books.remove(book);
    notifyListeners();
  }
}
*/
