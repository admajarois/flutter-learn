import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fakeflix/controllers/video_page_data_controller.dart';
import 'package:fakeflix/models/video_page_data.dart';

final videoPlayerControllerProvider = StateNotifierProvider<VideoPageDataController, VideoPageData>(
  (ref) => VideoPageDataController(),
);

class VideoPlayerScreen extends ConsumerStatefulWidget {
  final int movieId;

  const VideoPlayerScreen({super.key, required this.movieId});

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  late VideoPageDataController _videoPageDataController;
  late String _videoUrl;

  @override
  void initState() {
    super.initState();
    _videoPageDataController = ref.read(videoPlayerControllerProvider.notifier);
    _fetchMovieTrailer();
  }


  Future<void> _fetchMovieTrailer() async {
    await _videoPageDataController.getMovieTrailer(widget.movieId);
    final videoPageData = ref.watch(videoPlayerControllerProvider);
    _videoUrl = videoPageData.trailer;
    final videoId = YoutubePlayer.convertUrlToId(_videoUrl);

    setState(() {
      _controller = YoutubePlayerController(
        initialVideoId: videoId ?? '',
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,    
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blue,
          progressColors: ProgressBarColors(
            playedColor: Colors.blue,
            handleColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}

