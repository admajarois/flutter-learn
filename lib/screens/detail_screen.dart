import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailScreen extends ConsumerWidget {
  final int movieId;

  const DetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI(context, ref, deviceHeight, deviceWidth);
  }

  Widget _buildUI(BuildContext context, WidgetRef ref, double deviceHeight, double deviceWidth) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Text('Detail Screen'),
          ],
        ),
      ),
    );
  }
}

