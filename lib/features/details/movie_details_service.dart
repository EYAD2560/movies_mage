import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';

class MovieDetailsService {
  Future<GlobalModel> fetchMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse(
        '$kbaseurl/movie/$movieId?api_key=$kapikey&language=en-US',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<String> genreNames = (data['genres'] as List<dynamic>)
          .map((g) => g['name'].toString())
          .toList();
      return GlobalModel.fromJson(data, genreNames);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<GlobalModel> fetchTvShowDetails(int tvId) async {
    final response = await http.get(
      Uri.parse(
        '$kbaseurl/tv/$tvId?api_key=$kapikey&language=en-US',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<String> genreNames = (data['genres'] as List<dynamic>)
          .map((g) => g['name'].toString())
          .toList();
      return GlobalModel.fromJson(data, genreNames);
    } else {
      throw Exception('Failed to load TV show details');
    }
  }
}
