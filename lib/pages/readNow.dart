import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/books.dart';

class ReadNow extends StatelessWidget {
  final Book book;

  const ReadNow({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
        backgroundColor: const Color(0xFF42A5F5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: book.pdf.isNotEmpty
          ? FutureBuilder(
              future: _loadPdf(book.pdf),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: Unable to load PDF\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return SfPdfViewer.asset(snapshot.data as String);
              },
            )
          : const Center(
              child: Text('PDF file is missing or unavailable.'),
            ),
    );
  }

  Future<String> _loadPdf(String path) async {
    // Simulate loading for debugging
    await Future.delayed(const Duration(milliseconds: 500));
    return path; // Return the path if it exists
  }
}
