import 'package:fakeflix/models/detail_page_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:fakeflix/services/movie_service.dart';
import 'package:fakeflix/services/credits_service.dart';

class DetailPageDataController extends StateNotifier<DetailPageData> {
  DetailPageDataController([DetailPageData? state]) : super(state ?? DetailPageData.initial()) {
    getMovieDetail(state?.movie.id ?? 0);
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();
  final CreditsService _creditsService = GetIt.instance.get<CreditsService>();

  Future<void> getMovieDetail(int movieId) async {
    if (state.movie.id == null) return;
    final movie = await _movieService.getMovieDetail(movieId);
    state = state.copyWith(movie: movie);
  }

  Future<void> getMovieCredits(int movieId) async {
    if (state.movie.id == null) return;
    final credits = await _creditsService.getMovieCredits(movieId);
    state = state.copyWith(credits: credits);
  }
}
