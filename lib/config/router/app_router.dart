// Third Party
import 'package:go_router/go_router.dart';

// Project
import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (_, __) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (_, state) {
            final movieID = state.pathParameters['id'] ?? 'no-id';

            return MovieScreen(movieID: movieID);
          },
        ),
      ],
    ),
  ],
);
