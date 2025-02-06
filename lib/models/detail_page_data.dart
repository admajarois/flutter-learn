import 'package:fakeflix/models/movie.dart';
import 'package:fakeflix/models/credit.dart';

class DetailPageData {
  final Movie movie;
  final List<Credit> credits;
  final List<Movie> similarMovies;  
  final String trailer;

  DetailPageData({required this.movie, required this.credits, required this.similarMovies, required this.trailer});


  DetailPageData.initial()
  : movie = Movie.initial(),
    trailer = '',
    credits = [],
    similarMovies = [];


  DetailPageData copyWith({
    Movie? movie,
    String? trailer,
    List<Credit>? credits,
    List<Movie>? similarMovies,
  }) {


    return DetailPageData(
      movie: movie ?? this.movie,
      credits: credits ?? this.credits,
      similarMovies: similarMovies ?? this.similarMovies,
      trailer: trailer ?? this.trailer,
    );
  }
}