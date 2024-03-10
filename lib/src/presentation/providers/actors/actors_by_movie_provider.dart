import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movies_app/src/domain/entities/actor.dart';
import 'package:movies_app/src/presentation/providers/providers.dart';

final actorByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, ActorsByMovieState>((ref) {
  final getActors = ref.watch(actorsRepositoryProvider).getActorsByMovie;

  return ActorsByMovieNotifier(getActorsCallback: getActors);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<ActorsByMovieState> {
  final GetActorsCallback getActorsCallback;

  ActorsByMovieNotifier({required this.getActorsCallback})
      : super(ActorsByMovieState(actorsCache: {}));

  Future<void> loadActors(String movieId) async {
    if (state.actorsCache[movieId] != null) return;

    final actors = await getActorsCallback(movieId);
    state = state.copyWith(actorsCache: {
      ...state.actorsCache,
      movieId: actors,
    });
  }
}

class ActorsByMovieState {
  final Map<String, List<Actor>> actorsCache;

  ActorsByMovieState({required this.actorsCache});

  ActorsByMovieState copyWith({
    Map<String, List<Actor>>? actorsCache,
  }) {
    return ActorsByMovieState(
      actorsCache: actorsCache ?? this.actorsCache,
    );
  }
}
