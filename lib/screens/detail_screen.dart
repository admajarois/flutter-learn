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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _detailPageDataController = ref.watch(detailPageDataControllerProvider.notifier);
    _detailPageData = ref.watch(detailPageDataControllerProvider);
    return _buildUI(context, ref);
  }

  Widget _buildUI(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: _deviceWidth,
        height: _deviceHeight,
        child: Stack(
          children: [
            _buildBackground(),
            _buildMovieBackdrop(),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieInfo() {
    final Movie movie = _detailPageData.movie;
    final List<Credit> credits = _detailPageData.credits;




    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
    );
  }

  Widget _buildBackground() {
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(
            'https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg'
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: Colors.black26,
        ),
      ),
    );
  }

  Widget _buildMovieBackdrop() {
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg'
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

