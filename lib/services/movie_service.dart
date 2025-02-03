import 'package:get_it/get_it.dart';
import 'package:fakeflix/services/http_service.dart';
import 'package:dio/dio.dart';

import 'package:fakeflix/models/movie.dart';
import 'package:fakeflix/models/credit.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HttpService _http;

  MovieService() {
    _http = getIt.get<HttpService>();
  }

  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    Response response = await _http.get('/movie/popular', params: {
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
    Response response = await _http.get('/movie/upcoming', params: {
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
    Response response = await _http.get('/search/movie', params: {
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
    try {
      Response response = await _http.get('/movie/$movieId');
      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      } else {
        return Movie.initial();
      }
    } catch (e) {
      print('Error fetching movie detail: $e');
      return Movie.initial();
    }
  }

  Future<List<Credit>> getMovieCredits(int movieId) async {
    try {
      Response response = await _http.get('/movie/$movieId/credits');
      if (response.statusCode == 200) {
        return (response.data['cast'] as List)
            .map<Credit>((creditData) => Credit.fromJson(creditData))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching movie credits: $e');
      return [];
    }
  }

  Future<List<Movie>> getSimilarMovies(int movieId) async {
    try {
      Response response = await _http.get('/movie/$movieId/similar');
      if (response.statusCode == 200) {
        return (response.data['results'] as List)

          .map<Movie>((movieData) => Movie.fromJson(movieData))
          .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching similar movies: $e');
      return [];
    }
  }
}