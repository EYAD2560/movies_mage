import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';

class GenreService {

  /// Fetches genre map for the given content type.
  /// If no contentType is provided, defaults to 'movie'.
  Future<Map<int, String>> fetchGenres({String contentType = 'movie'}) async {
    final url = Uri.parse(
      '$kbaseurl/genre/$contentType/list?api_key=$kapikey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final genres = data['genres'] as List;

      return {
        for (var genre in genres) genre['id']: genre['name'],
      };
    } else {
      throw Exception('Failed to load $contentType genres');
    }
  }

  /// Helper method to map genre IDs to names using the provided genre map.
  List<String> mapGenreIds(List<dynamic> genreIds, Map<int, String> genreMap) {
    return genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
  }
}
