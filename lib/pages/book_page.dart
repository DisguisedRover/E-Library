import 'package:flutter/material.dart';
import 'package:book_library/models/books.dart';
import 'package:book_library/pages/book_detailPage.dart';
import 'package:book_library/models/library.dart'; // Add the import for Library singleton

/// Displays a list of books for a specific faculty.
class BookPage extends StatelessWidget {
  final BookFaculty faculty;

  const BookPage({
    super.key,
    required this.faculty,
  });

  @override
  Widget build(BuildContext context) {
    // Filter books based on the selected faculty
    final List<Book> booksForFaculty =
        Library().books.where((book) => book.faculty == faculty).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(faculty.displayName),
        backgroundColor: const Color(0xFF42A5F5),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: booksForFaculty.length,
        itemBuilder: (context, index) {
          final book = booksForFaculty[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              leading: Icon(
                Icons.book,
                color: Colors.blue[800],
                size: 40.0,
              ),
              title: Text(
                book.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
              onTap: () {
                // Navigate to BookDetailsPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailsPage(book: book),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
