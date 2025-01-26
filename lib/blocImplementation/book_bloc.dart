import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_library/services/api_service.dart';
import '../blocEvent/book_event.dart';
import '../blocState/book_state.dart';
import 'dart:io';

class BookBloc extends Bloc<BookEvent, BookState> {
  final ApiService apiService;

  BookBloc({required this.apiService}) : super(BookInitial()) {
    on<FetchBooksByFaculty>(_onFetchBooksByFaculty);
    on<AddBook>(_onAddBook);
  }

  Future<void> _onFetchBooksByFaculty(
    FetchBooksByFaculty event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoading());
    try {
      final books = await apiService
          .getBooksByFaculty(event.faculty.toString().split('.').last);
      emit(BookLoaded(books));
    } catch (error) {
      emit(BookError('Failed to fetch books: ${error.toString()}'));
    }
  }

  Future<void> _onAddBook(
    AddBook event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoading());
    try {
      File? pdfFile = event.pdfPath != null ? File(event.pdfPath!) : null;
      File? coverImage =
          event.imagePath != null ? File(event.imagePath!) : null;

      final book = await apiService.addBook(
        title: event.title,
        author: event.author,
        description: event.description,
        faculty: event.faculty.toString().split('.').last,
        pdfFile: pdfFile,
        coverImage: coverImage,
      );

      emit(BookAdded(book));
    } catch (error) {
      emit(BookError('Failed to add book: ${error.toString()}'));
    }
  }
}
