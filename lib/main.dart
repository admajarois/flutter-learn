// packages
import 'package:flutter/material.dart';
import 'package:fakeflix/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// screens
import 'screens/splash_screen.dart';
import 'screens/main_screen.dart';

import 'package:logger/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _logger = Logger();

  // Load config before app starts
  try {
    Config.load();
  } catch (e) {
    _logger.e('Error loading config: $e');
  }

  runApp(
    ProviderScope(
      child: SplashScreen(
        key: UniqueKey(), 
        onInitializationComplete: () {
          runApp(
            ProviderScope(
              child: const MyApp(),
            ),
          );
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fakeflix',
      initialRoute: 'home',
      routes: {
        'home': (context) => MainScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

