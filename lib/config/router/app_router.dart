// Third Party
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

// Project
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (_, __, currentChild) => HomeScreen(currentChild: currentChild),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeView(),
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  name: MovieScreen.name,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (_, state) {
                    final movieID = state.pathParameters['id'] ?? 'no-id';

                    return MovieScreen(movieID: movieID);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/favoritesa',
            builder: (context, state) => const FavoritesView(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoritesView(),
          ),
        ]),
      ],
    ),
  ],
);


// Parent Routes & Child Routes
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (_, __) => const HomeScreen(childView: HomeView()),
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:id',
    //       name: MovieScreen.name,
    //       builder: (_, state) {
    //         final movieID = state.pathParameters['id'] ?? 'no-id';

    //         return MovieScreen(movieID: movieID);
    //       },
    //     ),
    //   ],
    // ),