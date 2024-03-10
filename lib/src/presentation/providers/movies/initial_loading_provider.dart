import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/presentation/providers/providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).movies.isEmpty;
  final step2 = ref.watch(popularMoviesProvider).movies.isEmpty;
  final step3 = ref.watch(topRatedMoviesProvider).movies.isEmpty;
  final step4 = ref.watch(upcomingMoviesProvider).movies.isEmpty;

  if (step1 || step2 || step3 || step4) return true;
  return false;
});
