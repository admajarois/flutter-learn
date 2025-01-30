import 'package:fakeflix/config/config.dart';

//package
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HttpService {
  
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  late String _baseUrl;
  late String _apiKey;
  
  HttpService() {
    
    _baseUrl = Config.baseUrl!;
    _apiKey = Config.apiKey!;
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String url = '$_baseUrl$path';  
      Map<String, dynamic> query0 = {
        'api_key': _apiKey,
        'language': 'en-US',
      };
      if (query != null) {
        query0.addAll(query);
      }
      return await dio.get(url, queryParameters: query0);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}