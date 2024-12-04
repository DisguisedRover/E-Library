/// Represents a book in the library.
class Book {
  final String name; // Title of the book
  final BookFaculty faculty; // Associated faculty
  final String imagepath; // Path to the book's image
  final String description; // Description of the book
  final String pdf;

  const Book({
    required this.name,
    required this.faculty,
    required this.imagepath,
    required this.description,
    required this.pdf,
  });
}

/// Enum representing faculties to which books belong.
enum BookFaculty {
  BIM,
  BHM,
}

/// Extension to provide readable names for [BookFaculty].
extension BookFacultyExtension on BookFaculty {
  String get displayName {
    switch (this) {
      case BookFaculty.BIM:
        return "Bachelor in Information Management";
      case BookFaculty.BHM:
        return "Bachelor in Hotel Management";
    }
  }
}
