import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../auth/authentication_bloc.dart';
import '../core/listenables.dart';
import '../ui/login/login_page.dart';
import '../ui/shell/books_shell.dart';
import '../ui/books/by_author_page.dart';
import '../ui/books/by_title_page.dart';
import '../ui/books/book_detail_page.dart';
import '../ui/profile/profile_page.dart';

GoRouter buildRouter(AuthenticationBloc authBloc) {
  final refresh = BlocGoRouterListenable(authBloc.stream);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: refresh,
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (_, __) => const MaterialPage(child: LoginPage()),
      ),
      ShellRoute(
        builder: (_, __, child) => BooksShell(child: child),
        routes: [
          GoRoute(
            path: '/byAuthor',
            name: 'byAuthor',
            pageBuilder: (_, __) => const MaterialPage(child: ByAuthorPage()),
            routes: [
              GoRoute(
                path: 'detail/:id',
                name: 'byAuthorDetail',
                pageBuilder: (_, state) =>
                    MaterialPage(child: BookDetailPage(bookId: state.pathParameters['id']!)),
              ),
            ],
          ),
          GoRoute(
            path: '/byTitle',
            name: 'byTitle',
            pageBuilder: (_, __) => const MaterialPage(child: ByTitlePage()),
            routes: [
              GoRoute(
                path: 'detail/:id',
                name: 'byTitleDetail',
                pageBuilder: (_, state) =>
                    MaterialPage(child: BookDetailPage(bookId: state.pathParameters['id']!)),
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (_, __) => const MaterialPage(child: ProfilePage()),
          ),
        ],
      ),
    ],
    redirect: (ctx, state) {
      final auth = ctx.read<AuthenticationBloc>().state.status;
      final loggingIn = state.matchedLocation == '/login';
      if (auth == AuthStatus.loggedOut && !loggingIn) return '/login';
      if (auth == AuthStatus.loggedIn && loggingIn) return '/byAuthor';
      return null;
    },
  );
}
