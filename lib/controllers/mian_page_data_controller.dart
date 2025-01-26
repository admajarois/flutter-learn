import 'package:fakeflix/models/main_page_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:fakeflix/models/search_category.dart';

// services
import 'package:fakeflix/services/movie_service.dart';
import 'package:fakeflix/models/movie.dart';



class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state]) : super(state ?? MainPageData.intial()){
    getMovies();
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie> movies = [];
      if (state.searchText.isEmpty) {
        if (state.searchCategory == SearchCategory.popular) {
          movies = await _movieService.getPopularMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.upcoming) {
          movies = await _movieService.getUpcomingMovies(page: state.page);
        } 
      } else {
        movies = await _movieService.getSearchMovies(
          searchText: state.searchText,
          page: state.page,
        );  
      }
      state = state.copyWith(
        movies: [...state.movies, ...movies],
        page: state.page + 1,
      );
    } catch (e) {
      print(e);
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
      print(e);
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
      print(e);
    }
  }
}


