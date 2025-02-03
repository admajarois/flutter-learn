import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailInfo extends StatefulWidget {
  final Movie movie;

  final double deviceWidth;
  final double deviceHeight;

  const MovieDetailInfo({
    Key? key, 
    required this.movie, 
    required this.deviceWidth, 
    required this.deviceHeight
    }) : super(key: key);
  
  @override
  State<MovieDetailInfo> createState() => _MovieDetailInfoState();
  
}

class _MovieDetailInfoState extends State<MovieDetailInfo> {

  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
     return SizedBox(
      width: widget.deviceWidth * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
           Row(
              children: [
                Expanded(
                  child: Text(widget.movie.title ?? '', 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 22, 
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(widget.movie.rating?.toStringAsFixed(1) ?? '', 
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
                '${widget.movie.language?.toUpperCase() ?? ''} | R: ${widget.movie.isAdult ?? false ? 'Yes' : 'No'} | ${widget.movie.releaseDate ?? ''}', 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 12, 
                ),
              ),

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Container(
                width: widget.deviceWidth * 0.85,
                height: widget.deviceHeight * 0.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: TextButton.icon(onPressed: () {}, label: Text('Watch Now'), icon: Icon(Icons.play_arrow, color: Colors.black,),),
              ),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.overview ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  maxLines: _isExpanded ? null : 2,
                  overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                if (widget.movie.overview != null && widget.movie.overview!.length > 100)
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;

                      });
                    },
                    child: Text(
                      _isExpanded ? 'See Less' : 'See More',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}