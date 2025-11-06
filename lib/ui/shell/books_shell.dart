import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BooksShell extends StatefulWidget {
  final Widget child;
  const BooksShell({super.key, required this.child});

  @override
  State<BooksShell> createState() => _BooksShellState();
}

class _BooksShellState extends State<BooksShell> {
  /*
  int _indexFor(String loc) {
    if (loc.startsWith('/byTitle')) return 1;
    if (loc.startsWith('/profile')) return 2;
    return 0;
  }

  void _go(int i) {
    switch (i) {
      case 0: context.go('/byAuthor'); break;
      case 1: context.go('/byTitle');  break;
      case 2: context.go('/profile');  break;
    }
  }
*/
@override
Widget build(BuildContext context) {
  final loc = GoRouterState.of(context).uri.toString();
  final inDetail = loc.startsWith('/byAuthor/detail') || loc.startsWith('/byTitle/detail');

  return Scaffold(
    appBar: AppBar(
      title: Text(inDetail ? 'Book' : 'Books'),
      leading: inDetail
          ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop())
          : Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
      actions: inDetail
          ? null
          : const [
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.account_circle_outlined),
              ),
            ],
    ),
    drawer: const Drawer(child: Center(child: Text('Menu'))),
    body: SafeArea(child: widget.child),

    bottomNavigationBar: inDetail ? null : _buildNavBar(loc),
    //bottomNavigationBar: _buildNavBar(loc),
  );
}

Widget _buildNavBar(String loc) {
  int indexFor(String l) => l.startsWith('/byTitle') ? 1 : l.startsWith('/profile') ? 2 : 0;
  void goTo(BuildContext c, int i) {
    switch (i) { case 0: c.go('/byAuthor'); break; case 1: c.go('/byTitle'); break; case 2: c.go('/profile'); break; }
  }

  return NavigationBar(
    selectedIndex: indexFor(loc),
    onDestinationSelected: (i) => goTo(context, i),
    destinations: const [
      NavigationDestination(icon: Icon(Icons.person_outline), label: 'By Author'),
      NavigationDestination(icon: Icon(Icons.format_size),   label: 'By Title'),
      NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Profile'),
    ],
  );
}
}
