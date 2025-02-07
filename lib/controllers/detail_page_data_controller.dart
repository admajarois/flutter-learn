import 'package:fakeflix/models/detail_page_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:fakeflix/services/movie_service.dart';
import 'package:fakeflix/services/credits_service.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

class DetailPageDataController extends StateNotifier<DetailPageData> {
  DetailPageDataController([DetailPageData? state]) : super(state ?? DetailPageData.initial()) {
    getMovieDetail(state?.movie.id ?? 0);
  }

  final _logger = Logger();
  final MovieService _movieService = GetIt.instance.get<MovieService>();
  final CreditsService _creditsService = GetIt.instance.get<CreditsService>();

  Future<void> getMovieDetail(int movieId) async {
    try {
      if (state.movie.id == null) return;
      final movie = await _movieService.getMovieDetail(movieId);
      state = state.copyWith(movie: movie);
    } on DioException catch (e) {
      _logger.e('Error getting movie detail: ${e.response?.statusCode} - ${e.response?.statusMessage}');
    } catch (e) {
      _logger.e('Error getting movie detail: $e');
    }
  }

  Future<void> getSimilarMovies(int movieId) async {  
    try {
      final similarMovies = await _movieService.getSimilarMovies(movieId);
      state = state.copyWith(similarMovies: similarMovies);
    } catch (e) {
      _logger.e('Error getting similar movies: $e');
    }
  }
  Future<void> getMovieCredits(int movieId) async {
    try {
      final credits = await _creditsService.getMovieCredits(movieId);
      state = state.copyWith(credits: credits);
    } catch (e) {
      _logger.e('Error getting movie credits: $e');
    }
  }
}
