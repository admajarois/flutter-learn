//package
import 'package:flutter/material.dart';
import 'package:fakeflix/config/config.dart';
import 'package:get_it/get_it.dart';

// services
import 'package:fakeflix/services/http_service.dart';
import 'package:fakeflix/services/movie_service.dart';

class SplashScreen extends StatefulWidget {

  final VoidCallback onInitializationComplete;

  const SplashScreen({super.key, required this.onInitializationComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  final GetIt getIt = GetIt.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then(
      (_) => _setup().then(
        (_) => widget.onInitializationComplete())
    );
  }

  Future<void> _setup() async {
    getIt.registerSingleton<Config>(Config());

    getIt.registerSingleton<HttpService>(
      HttpService()
    );

    getIt.registerSingleton<MovieService>(
      MovieService()
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fakeflix',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Center(
        child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.contain,
              ),
            ),
        ),
      ),
    );
  }
}

