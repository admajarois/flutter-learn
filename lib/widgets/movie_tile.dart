import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:fakeflix/models/movie.dart';

class MovieTile extends StatelessWidget {

  final GetIt _getIt = GetIt.instance;

  final double height;
  final double width;
  final Movie movie;

  MovieTile({
    required this.height,
    required this.width,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _moviePosterWidget(),
          _movieInfoWidget(),
        ],
      )
    );
  }

  Widget _moviePosterWidget() {
    return Container(
      height: height,
      width: width * 0.35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(movie.posterPath ?? ''),
        ),
      ),
    );
  }

  Widget _movieInfoWidget() {
    return Container(
      height: height,
      width: width * 0.66,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: width * 0.56,
                child: Text(
                  movie.title ?? '', 
                  overflow: TextOverflow.ellipsis, 
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                movie.rating.toString(), 
                style: TextStyle(fontSize: 22, 
                  fontWeight: FontWeight.w400, 
                  color: Colors.white,
                )
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
            child: Text(
              '${movie.language?.toUpperCase() ?? ''} | R: ${movie.isAdult ?? false ? 'Yes' : 'No'} | ${movie.releaseDate ?? ''}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.07, 0, 0),
            child: Text(
              movie.overview ?? '',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ) 
        ],
      ),
    );
  }
}