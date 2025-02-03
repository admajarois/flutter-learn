import 'package:fakeflix/models/movie.dart';
import 'package:fakeflix/models/credit.dart';

class DetailPageData {
  final Movie movie;
  final List<Credit> credits;
  final List<Movie> similarMovies;  

  DetailPageData({required this.movie, required this.credits, required this.similarMovies});


  DetailPageData.initial()
  : movie = Movie.initial(),
    credits = [],
    similarMovies = [];


  DetailPageData copyWith({
    Movie? movie,
    List<Credit>? credits,
    List<Movie>? similarMovies,
  }) {

    return DetailPageData(
      movie: movie ?? this.movie,
      credits: credits ?? this.credits,
      similarMovies: similarMovies ?? this.similarMovies,
    );
  }
}