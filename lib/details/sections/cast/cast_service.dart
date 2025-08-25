import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'cast_model.dart';

class CastService {
  static String baseUrl = kbaseurl;
  static final String apiKey = kapikey;

  Future<Map<String, dynamic>> fetchCastAndDirector({
    required int id,
    required String contentType,
  }) async {
    try {
      final type = contentType == 'anime' ? 'tv' : contentType;
      final url = Uri.parse('$baseUrl/$type/$id/credits?api_key=$apiKey');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);

        /// Parse cast
        final castList = (jsonBody['cast'] as List)
            .map((json) => CastModel.fromJson(json))
            .toList();

        /// Parse crew for director
        final crewList = jsonBody['crew'] as List;
        final directors = crewList
            .where((member) => member['job'] == 'Director')
            .toList();

        final director = directors.isNotEmpty
            ? DirectorModel.fromJson(directors.first)
            : null;

        return {'cast': castList, 'director': director};
      } else {
        throw Exception('Failed to load credits');
      }
    } catch (e) {
      return {'cast': [], 'director': null};
    }
  }
}
