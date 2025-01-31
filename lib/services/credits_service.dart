import 'package:get_it/get_it.dart';
import 'package:fakeflix/services/http_service.dart';
import 'package:dio/dio.dart';

import 'package:fakeflix/models/credit.dart';

class CreditsService {
  final GetIt getIt = GetIt.instance;

  late HttpService _http;

  CreditsService() {
    _http = getIt.get<HttpService>();
  }

  Future<List<Credit>> getMovieCredits(int movieId) async {
    Response response = await _http.get('/movie/$movieId/credits', query: {
      'language': 'en-US',
    });
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Credit> credits = data['cast'].map<Credit>((creditData) => Credit.fromJson(creditData)).toList();
      return credits;
    } else {
      throw Exception('Failed to load movie credits');
    }
  }
}