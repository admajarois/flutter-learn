import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// services
import 'package:fakeflix/models/detail_page_data.dart';
import 'package:fakeflix/controllers/detail_page_data_controller.dart';

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
  late DetailPageData _detailPageData;
  late DetailPageDataController _detailPageDataController;
  late Movie _movie;
  late List<Credit> _credits;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _detailPageDataController = ref.watch(detailPageDataControllerProvider.notifier);
    _detailPageData = ref.watch(detailPageDataControllerProvider);
    _detailPageDataController.getMovieDetail(movieId);
    _detailPageDataController.getMovieCredits(movieId);
    _movie = _detailPageData.movie;
    _credits = _detailPageData.credits;
    return _buildUI(context, ref);
  }

  Widget _buildUI(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildMovieBackdrop(context, _movie),
      body: SizedBox(
        width: _deviceWidth,
        height: _deviceHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildMovieInfo(),
              _buildMovieCredits(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieInfo() {
    if (_movie.id != null) {
      return SizedBox(
        width: _deviceWidth * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(_movie.title ?? '', 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 22, 
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(_movie.rating?.toStringAsFixed(1) ?? '', 
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 16, 
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text(
                '${_movie.language?.toUpperCase() ?? ''} | R: ${_movie.isAdult ?? false ? 'Yes' : 'No'} | ${_movie.releaseDate ?? ''}', 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 12, 
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text(_movie.overview ?? '', 
                style: TextStyle( 
                  color: Colors.white, 
                  fontSize: 12, 
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }

  PreferredSize _buildMovieBackdrop(BuildContext context, Movie movie) {
    return PreferredSize(
      preferredSize: Size.fromHeight(_deviceHeight * 0.30),
      child: SizedBox(
        height: _deviceHeight * 0.30,
        width: _deviceWidth,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    movie.backdropUrl(),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
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
  
  Widget _buildMovieCredits() {
    if (_credits.isNotEmpty) {
      return SizedBox(
        height: _deviceHeight * 0.25,
        width: _deviceWidth * 0.85,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            childAspectRatio: 1.0, // Aspect ratio of each item
          ),
          itemCount: _credits.length,
          itemBuilder: (context, index) {
            return _buildCreditCard(_credits[index]);
          },
        ),
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
    return Stack(
      children: [
        Container(
          height: _deviceHeight * 0.25,
          width: _deviceWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(credit.profileUrl()),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Text(credit.name ?? '', 
            style: TextStyle(
              color: Colors.white, 
              fontSize: 12, 
            ),
          ),
        ),  
      ],
    );
  }
}

