import 'package:fakeflix/models/main_page_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:fakeflix/models/search_category.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

// services
import 'package:fakeflix/services/movie_service.dart';
import 'package:fakeflix/models/movie.dart';



class MainPageDataController extends StateNotifier<MainPageData> {
  final _logger = Logger();

  MainPageDataController([MainPageData? state]) : super(state ?? MainPageData.intial()){
    getMovies();
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie> movies = [];
      if (state.searchText.isEmpty) {
        if (state.searchCategory == SearchCategory.popular) {
          _logger.i('Fetching popular movies, page: ${state.page}');
          movies = await _movieService.getPopularMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.upcoming) {
          _logger.i('Fetching upcoming movies, page: ${state.page}');
          movies = await _movieService.getUpcomingMovies(page: state.page);
        } 
      } else {
        _logger.i('Searching movies with text: ${state.searchText}, page: ${state.page}');
        movies = await _movieService.getSearchMovies(
          searchText: state.searchText,
          page: state.page,
        );  
      }
      state = state.copyWith(
        movies: [...state.movies, ...movies],
        page: state.page + 1,
      );
    } on DioException catch (e) {
      if (e.response != null) {
        _logger.e('Error fetching movies: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
        _logger.e('Error fetching movies: ${e.message}');
      }
    } catch (e) {
      _logger.e('Unexpected error fetching movies', e);
    }
  }

  void updateSearchCategory(String category) {
    try {
      state = state.copyWith(
        movies: [],
        page: 1,
        searchCategory: category,
        searchText: '',
      );
      getMovies();
    } catch (e) {
      _logger.e('Error updating search category', e);
    }
  }

  void updateSearchText(String text) {
    try {
      state = state.copyWith(
        movies: [],
        page: 1,
        searchText: text,
      );
      getMovies();
    } catch (e) {
      _logger.e('Error updating search text', e);
    }
  }
}


