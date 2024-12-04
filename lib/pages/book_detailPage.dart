import 'package:book_library/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:book_library/models/books.dart';
import 'readNow.dart';

/// Displays detailed information about a book.
class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name), // Display the book's name in the app bar
        backgroundColor: const Color(0xFF42A5F5),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book image
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Image.asset(
                book.imagepath.isNotEmpty
                    ? book.imagepath
                    : 'assets/images/placeholder.png', // Fallback image
                fit: BoxFit.fitHeight,
                width: MediaQuery.of(context).size.width, // Full width
                height: 300, // Fixed height
              ),
            ),

            // Padding for details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book title
                  Text(
                    book.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Book faculty
                  Text(
                    'Faculty: ${book.faculty.displayName}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Book description
                  Text(
                    book.description.isNotEmpty
                        ? book.description
                        : 'No description available for this book.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Button to read the book
                  Center(
                    child: MyButton(
                      text: 'R E A D',
                      onTap: () {
                        if (book.pdf.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReadNow(book: book),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No PDF available for this book'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
