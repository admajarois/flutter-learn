import 'package:fakeflix/models/movie.dart';
import 'package:fakeflix/models/credit.dart';

class DetailPageData {
  final Movie movie;
  final List<Credit> credits;

  DetailPageData({required this.movie, required this.credits});

  DetailPageData.initial()
  : movie = Movie.initial(),
    credits = [];

  DetailPageData copyWith({
    Movie? movie,
    List<Credit>? credits,
  }) {
    return DetailPageData(
      movie: movie ?? this.movie,
      credits: credits ?? this.credits,
    );
  }
}