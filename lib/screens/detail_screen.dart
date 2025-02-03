import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// services
import 'package:fakeflix/models/detail_page_data.dart';
import 'package:fakeflix/controllers/detail_page_data_controller.dart';

// widgets
import 'package:fakeflix/widgets/movie_detail_info.dart';

//models
import 'package:fakeflix/models/movie.dart';
import 'package:fakeflix/models/credit.dart';



final detailPageDataControllerProvider = StateNotifierProvider<DetailPageDataController, DetailPageData>(
  (ref) => DetailPageDataController(),
);

class DetailScreen extends ConsumerWidget {
  final int movieId;

  DetailScreen({super.key, required this.movieId});

  late double _deviceHeight;
  late double _deviceWidth;
  late DetailPageDataController _detailPageDataController;
  late Movie movie;
  late List<Movie> similarMovies;
  late List<Credit> credits;

  bool _isNavigating = false;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _detailPageDataController = ref.watch(detailPageDataControllerProvider.notifier);

    return FutureBuilder(
      future: _fetchMovieDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return _buildUI(context, ref);
        }
      },
    );
  }

  Future<void> _fetchMovieDetails() async {
    await _detailPageDataController.getMovieDetail(movieId);
    await _detailPageDataController.getMovieCredits(movieId);
    await _detailPageDataController.getSimilarMovies(movieId);
  }

  Widget _buildUI(BuildContext context, WidgetRef ref) {
    final detailPageData = ref.watch(detailPageDataControllerProvider);
    final movie = detailPageData.movie;
    final credits = detailPageData.credits;
    final similarMovies = detailPageData.similarMovies;
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildMovieBackdrop(context, movie),
      body: SizedBox(
        width: _deviceWidth,
        height: _deviceHeight,
        child: SingleChildScrollView(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildMovieInfo(movie),
              SizedBox(height: 16),
              _buildMovieCredits(credits),
              SizedBox(height: 16),
              _buildSimilarMovies(similarMovies),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieInfo(Movie movie) {
    return MovieDetailInfo(movie: movie, deviceWidth: _deviceWidth, deviceHeight: _deviceHeight);
  }

  PreferredSize _buildMovieBackdrop(BuildContext context, Movie movie) {
    return PreferredSize(
      preferredSize: Size.fromHeight(_deviceHeight * 0.30),
      child: SizedBox(
        height: _deviceHeight * 0.30,
        width: _deviceWidth,
        child: Stack(
          children: [
            if (movie.backdropPath?.isNotEmpty ?? false)
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(movie.backdropUrl()),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                color: Colors.black,
              ),
            Container(
              height: _deviceHeight * 0.30,
              width: _deviceWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white24,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMovieCredits(List<Credit> credits) {
    if (credits.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('Cast', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),),
          SizedBox(height: 10),
          SizedBox(
            height: _deviceHeight * 0.50,
            width: _deviceWidth * 0.85,

            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.0, // Aspect ratio of each item
              ),
              itemCount: credits.length,
              itemBuilder: (context, index) {
                return _buildCreditCard(credits[index]);
              },
            ),
          ),
        ],
      );
    } else {

      return Center(

        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }

  Widget _buildCreditCard(Credit credit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: _deviceHeight * 0.20,
          width: _deviceWidth * 0.30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(credit.profileUrl()),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(credit.name ?? '', 
            style: TextStyle(
              color: Colors.white, 
              fontSize: 12, 
            ),
        ),
      ],
    );
  }

  Widget _buildSimilarMovies(List<Movie> similarMovies) {
    if (similarMovies.isNotEmpty) {
      return Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('Similar Movies', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),),
          SizedBox(height: 10),
          SizedBox(
            height: _deviceHeight * 0.30,
            width: _deviceWidth * 0.85,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: similarMovies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: GestureDetector(
                    onTap: () {
                      if (!_isNavigating) {
                        _isNavigating = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailScreen(movieId: similarMovies[index].id!)),
                        ).then((_) {
                          _isNavigating = false;
                        });
                      }
                    },
                    child:  _buildSimilarMovieCard(similarMovies[index]),
                  ),
                );
              },




            ),
          ),
        ],
      );

    } else {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }

  Widget _buildSimilarMovieCard(Movie movie) {
    return Container(
      height: _deviceHeight * 0.30,
      width: _deviceWidth * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(

          image: NetworkImage(movie.posterUrl()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


