import 'package:fakeflix/models/main_page_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

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
      movies = await _movieService.getPopularMovies(page: state.page);
      state = state.copyWith(
        movies: [...state.movies, ...movies],
        page: state.page + 1,
      );
    } catch (e) {
      print(e);
    }
  }
}


