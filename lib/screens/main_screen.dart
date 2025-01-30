// Packages
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/search_category.dart';
import '../widgets/movie_tile.dart';
import '../models/movie.dart';
import '../models/main_page_data.dart';

import '../controllers/mian_page_data_controller.dart';

import '../screens/detail_screen.dart';

final mainPageDataControllerProvider = 
  StateNotifierProvider<MainPageDataController, MainPageData>(
    (ref) => MainPageDataController());




class MainScreen extends ConsumerWidget {
  MainScreen({super.key});

  late double _deviceHeight;
  late double _deviceWidth;
  late MainPageDataController _mainPageDataController;
  late MainPageData _mainPageData;
  late TextEditingController _searchController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _mainPageDataController = ref.watch(mainPageDataControllerProvider.notifier);
    _mainPageData = ref.watch(mainPageDataControllerProvider);
    _searchController = TextEditingController();
    _searchController.text = _mainPageData.searchText;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildBackground(),
            _buildForeground(),
          ],
        )
      )
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
            'https://plus.unsplash.com/premium_photo-1683865776032-07bf70b0add1?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
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

  Widget _buildForeground() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _deviceHeight * 0.08, 0, 0),
      width: _deviceWidth * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ 
          _topBarWidget(),
          Expanded(
            child: _movieListViewWidget(),
          ),
        ],
      )
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      width: _deviceWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchWidget(),
          _categorySelectionWidget(),
        ],
      ),
    );
  }

  Widget _searchWidget() {
    final border = InputBorder.none;
    return SizedBox(
      width: _deviceWidth * 0.50,
      height: _deviceHeight * 0.05,
      child: TextField(
        controller: _searchController,
        style: TextStyle(color: Colors.white),
        onSubmitted: (input) => _mainPageDataController.updateSearchText(input.toString()),
          decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white),
          focusedBorder: border,
          border: border,
          prefixIcon: Icon(Icons.search, color: Colors.white,),
        ),
      ),
    );
  }
  
  Widget _categorySelectionWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: _mainPageData.searchCategory,
      icon: Icon(Icons.menu, color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (value) => value.toString().isNotEmpty 
        ? _mainPageDataController.updateSearchCategory(value.toString()) 
        : null,
      items: [
        DropdownMenuItem(
          value: SearchCategory.popular,
          child: Text(
            SearchCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.upcoming,
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.none,
          child: Text(
            SearchCategory.none,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ]
    );
  }

  Widget _movieListViewWidget() {
    final List<Movie> movies = _mainPageData.movies;

    if (movies.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            final before = scrollNotification.metrics.extentBefore;
            final max = scrollNotification.metrics.maxScrollExtent;
            if (before == max) {
              _mainPageDataController.getMovies();
              return true;
            }
            return false;
          }
          return true;
        },
        child: ListView.builder(
        
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.01, horizontal: 0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailScreen(movieId: movies[index].id!)),
                );
              },
              child: MovieTile(
                height: _deviceHeight * 0.20,
                width: _deviceWidth * 0.85,
                movie: movies[index],
              ),
            ),
          );
        },
          itemCount: movies.length,
        )
      );
    }else {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white ,
          ),
        );
    }
  }
}