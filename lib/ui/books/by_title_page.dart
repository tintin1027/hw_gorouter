import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/books_data.dart';
import '../../data/book.dart';

class ByTitlePage extends StatelessWidget {
  const ByTitlePage({super.key});
  @override
  Widget build(BuildContext context) {
    final sorted = [...books]..sort((a, b) => a.title.compareTo(b.title));
    return _BooksList(
      title: 'Sorted by Title',
      books: sorted,
      onTap: (b) => context.go('/byTitle/detail/${b.id}'),
    );
  }
}

class _BooksList extends StatelessWidget {
  final String title;
  final List<Book> books;
  final void Function(Book) onTap;
  const _BooksList({required this.title, required this.books, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      itemCount: books.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (ctx, i) {
        if (i == 0) return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
        );
        final b = books[i - 1];
        return InkWell(
          onTap: () => onTap(b),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFF9ECF9), borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(b.title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(b.author, style: Theme.of(context).textTheme.bodyMedium),
            ]),
          ),
        );
      },
    );
  }
}
