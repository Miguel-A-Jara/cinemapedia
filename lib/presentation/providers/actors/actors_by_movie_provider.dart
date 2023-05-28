// Third Party
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final fetchMovieInfo = ref.watch(actorsRepositoryProvider).getActorsByMovie;
  return ActorsByMovieNotifier(getActors: fetchMovieInfo);
});

/* 
  This is what the ActorsByMovieNotifier state looks like
  {
    '505642': List<Actor>,
    '205341': List<Actor>,
    '105232': List<Actor>,
    '312332': List<Actor>,
  }
*/

typedef GetActorsCallback = Future<List<Actor>> Function(String movieID);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String movieID) async {
    if (state[movieID] != null) return;

    final List<Actor> actors = await getActors(movieID);
    state = {...state, movieID: actors};
  }
}
