import 'package:get_it/get_it.dart';
import 'package:fakeflix/services/http_service.dart';
import 'package:dio/dio.dart';

import 'package:fakeflix/models/movie.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HttpService _http;

  MovieService() {
    _http = getIt.get<HttpService>();
  }

  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    Response response = await _http.get('/movie/popular', query: {
      'page': page,
    });
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((movieData) => Movie.fromJson(movieData)).toList();
      return movies;
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
    Response response = await _http.get('/movie/upcoming', query: {
      'page': page,
    });
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((movieData) => Movie.fromJson(movieData)).toList();
      return movies;
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<List<Movie>> getSearchMovies({String searchText= '', int page = 1}) async {
    Response response = await _http.get('/search/movie', query: {
      'query': searchText,
      'page': page,
    });
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((movieData) => Movie.fromJson(movieData)).toList();
      return movies;
    } else {
      throw Exception('Failed to load search movies');
    }
  }

  Future<Movie> getMovieDetail(int movieId) async {
    Response response = await _http.get('/movie/$movieId');
    if (response.statusCode == 200) {
      return Movie.fromJson(response.data);
    } else {
      throw Exception('Failed to load movie detail');
    }
  }
}