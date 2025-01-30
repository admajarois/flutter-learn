import 'package:fakeflix/config/config.dart';

class Movie {
  final String? title;
  final String? language;
  final bool? isAdult;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final num? rating;
  final int? id;
  final List<int>? genres;


  Movie({
    this.title,
    this.language,
    this.isAdult,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.rating,
    this.id,
    this.genres,
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
      id: json['id'],
      genres: (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );
  }

  String posterUrl() {
    return '${Config.imageUrl}$posterPath';
  }

  // String backdropUrl() {
  //   return '${Config.imageUrl}$backdropPath';
  // }
}
