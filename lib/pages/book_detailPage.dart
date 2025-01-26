import 'package:book_library/components/my_button.dart';
import 'package:book_library/services/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        title: Text(
          book.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF42A5F5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BookImage(imagePath: book.imagepath),
                _BookDetails(book: book),
                _ReadButton(book: book),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookImage extends StatelessWidget {
  const _BookImage({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final fullImageUrl = ApiService.getFullUrl(imagePath);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 600,
        child: CachedNetworkImage(
          imageUrl: fullImageUrl,
          fit: BoxFit.fill,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => _buildPlaceholder(),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey.shade300,
      child: const Icon(
        Icons.broken_image,
        size: 60,
        color: Colors.grey,
      ),
    );
  }
}

class _BookDetails extends StatelessWidget {
  const _BookDetails({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 12),
          if (book.author != null && book.author!.isNotEmpty)
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  'Author: ${book.author}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                ),
              ],
            ),
          const SizedBox(height: 12),
          Text(
            book.description.isNotEmpty
                ? book.description
                : 'No description available for this book.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}

class _ReadButton extends StatelessWidget {
  const _ReadButton({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: MyButton(
          text: 'R E A D',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
          color: Colors.blueAccent,
          padding: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onTap: () => _handleReadTap(context),
        ),
      ),
    );
  }

  void _handleReadTap(BuildContext context) {
    final pdfPath = book.pdfPath;

    if (pdfPath != null && pdfPath.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReadNow(book: book),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No PDF available for this book',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
