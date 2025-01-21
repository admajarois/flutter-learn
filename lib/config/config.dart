import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String? apiKey;
  static String? baseUrl; 
  static String? imageUrl;

  static void load() async {
    await dotenv.load(fileName: '.env');
    apiKey = dotenv.get('API_KEY');
    baseUrl = dotenv.get('BASE_URL');
    imageUrl = dotenv.get('IMAGE_URL');
  }
}
