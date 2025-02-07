import 'package:fakeflix/models/movie.dart';

class VideoPageData {
  final String trailer;
  final Movie movie;

  VideoPageData({
    required this.trailer,
    required this.movie,
  });




  VideoPageData.initial()
  : trailer = '',
    movie = Movie.initial();




  VideoPageData copyWith({
    String? trailer,
    Movie? movie,
  }) {


    return VideoPageData(
      trailer: trailer ?? this.trailer,
      movie: movie ?? this.movie,
    );


  }
}