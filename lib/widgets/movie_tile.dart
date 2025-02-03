import 'package:flutter/material.dart';
import 'package:fakeflix/models/movie.dart';

class MovieTile extends StatelessWidget {

  final double height;
  final double width;
  final Movie movie;

  const MovieTile({
    super.key,
    required this.height,
    required this.width,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _moviePosterWidget(),
        _movieInfoWidget(),
      ],
    );
  }

  Widget _moviePosterWidget() {
    return Container(
      height: height,
      width: width * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: NetworkImage(movie.posterUrl()),
        ),
      ),

    );
  }

  Widget _movieInfoWidget() {
    return SizedBox(
      height: height,
      width: width * 0.65,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  movie.title ?? '', 
                  overflow: TextOverflow.ellipsis, 
                  style: const TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                movie.rating?.toStringAsFixed(1) ?? '', 
                style: const TextStyle(
                  fontSize: 22, 
                  fontWeight: FontWeight.w400, 
                  color: Colors.white,
                )
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
            child: Text(
              '${movie.language?.toUpperCase() ?? ''} | R: ${movie.isAdult ?? false ? 'Yes' : 'No'} | ${movie.releaseDate ?? ''}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, height * 0.07, 0, 0),
            child: Text(
              movie.overview ?? '',
              style: const TextStyle(
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
              ),
              maxLines: 5,
              textAlign: TextAlign.justify,
            ),
          ) 
        ],
      ),
    ),
    );
  }
}