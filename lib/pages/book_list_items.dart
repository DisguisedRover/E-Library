import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:book_library/models/books.dart';
import 'package:book_library/services/api_service.dart';
import 'package:book_library/pages/book_detailPage.dart';
import 'package:shimmer/shimmer.dart';

class BookListItem extends StatelessWidget {
  final Book book;

  const BookListItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsPage(book: book),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover Image with Hero Animation
            Hero(
              tag: 'book-cover-${book.id}', // Ensure a unique tag for each book
              child: SizedBox(
                width: 100,
                height: 150,
                child: CachedNetworkImage(
                  imageUrl: ApiService.getFullUrl(book.imagepath ?? ''),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.grey[300],
                      width: 100,
                      height: 150,
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    debugPrint('Image load error: $error');
                    return const Icon(Icons.error, size: 40, color: Colors.red);
                  },
                ),
              ),
            ),

            // Book Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book Title
                    Text(
                      book.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Book Author
                    if (book.author != null && book.author!.isNotEmpty)
                      Text(
                        'Author: ${book.author}',
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),

                    // Book Faculty
                    Text(
                      book.faculty?.displayName ?? 'Unknown Faculty',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
