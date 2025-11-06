// ui/books/book_detail_page.dart
import 'package:flutter/material.dart';
import '../../data/books_data.dart';

class BookDetailPage extends StatelessWidget {
  final String bookId;
  const BookDetailPage({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final book = books.firstWhere((b) => b.id == bookId);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        'Detail of the Book', style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
