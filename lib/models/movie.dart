import 'package:fakeflix/config/config.dart';
import 'package:get_it/get_it.dart';


class Movie {
  final String? title;
  final String? language;
  final bool? isAdult;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final num? rating;


  Movie({
    this.title,
    this.language,
    this.isAdult,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      language: json['original_language'],
      isAdult: json['adult'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'],
      rating: json['vote_average'],
    );
  }

  String posterUrl() {
    return '${Config.imageUrl}$posterPath';
  }
}