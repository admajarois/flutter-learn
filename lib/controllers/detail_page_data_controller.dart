import 'package:fakeflix/models/detail_page_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:fakeflix/services/movie_service.dart';


class DetailPageDataController extends StateNotifier<DetailPageData> {
  DetailPageDataController([DetailPageData? state]) : super(state ?? DetailPageData.initial()) {
    getMovieDetail();
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovieDetail() async {
    if (state.movie.id == null) return;
    final movie = await _movieService.getMovieDetail(state.movie.id!);
    state = state.copyWith(movie: movie);
  }
}
