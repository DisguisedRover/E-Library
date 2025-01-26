import 'package:book_library/services/api_service.dart';
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
        title: Text(book.title),
        backgroundColor: const Color(0xFF42A5F5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildPdfViewer(),
    );
  }

  Widget _buildPdfViewer() {
    if (book.pdfPath != null) {
      final fullPdfUrl = ApiService.getFullUrl(book.pdfPath!);
      return SfPdfViewer.network(
        fullPdfUrl,
        onDocumentLoadFailed: (details) {
          print('Failed to load PDF: ${details.description}');
        },
      );
    } else {
      return const Center(
        child: Text('PDF file is missing or unavailable.'),
      );
    }
  }
}
