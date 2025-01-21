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

  Future<Response> get(String _path, {Map<String, dynamic>? query}) async {
    try {
      String _url = '$_baseUrl$_path';  
      Map<String, dynamic> _query = {
        'api_key': _apiKey,
        'language': 'en-US',
      };
      if (query != null) {
        _query.addAll(query);
      }
      return await dio.get(_url, queryParameters: _query);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}