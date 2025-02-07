import 'package:fakeflix/models/video_page_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fakeflix/services/movie_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';


class VideoPageDataController extends StateNotifier<VideoPageData> {

  VideoPageDataController([VideoPageData? state]) : super(state ?? VideoPageData.initial()){
    getMovieTrailer(state?.movie.id ?? 0);
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();
  final _logger = Logger();

  Future<void> getMovieTrailer(int movieId) async {
    try {
      final trailer = await _movieService.getMovieTrailer(movieId);
      final trailerUrl = 'https://www.youtube.com/watch?v=$trailer';
      state = state.copyWith(trailer: trailerUrl);
    } catch (e) {
      _logger.e('Error getting movie trailer: $e');
    }
  }

}
