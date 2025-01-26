//import 'package:book_library/pages/book_detailPage.dart';
import 'package:book_library/pages/book_list_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_library/models/books.dart';
import '../blocImplementation/book_bloc.dart';
import '../blocEvent/book_event.dart';
import '../blocState/book_state.dart';

class BookPage extends StatelessWidget {
  final BookFaculty faculty;

  const BookPage({super.key, required this.faculty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${faculty.displayName} Books'),
        backgroundColor: const Color(0xFF42A5F5),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        bloc: BookBloc(apiService: context.read())
          ..add(FetchBooksByFaculty(faculty)),
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF42A5F5),
              ),
            );
          } else if (state is BookLoaded) {
            return state.books.isEmpty
                ? const Center(child: Text('No books available'))
                : ListView.builder(
                    itemCount: state.books.length,
                    itemBuilder: (context, index) {
                      final book = state.books[index];
                      return BookListItem(book: book);
                    },
                  );
          } else if (state is BookError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: Text('Initialize book page'));
        },
      ),
    );
  }
}
