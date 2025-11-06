import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';

class TrailerService {
  static Future<String?> fetchTrailerKey(int movieId,
      {required String type}) async {
    final response = await http.get(
      Uri.parse('$kbaseurl/movie/$movieId/videos?api_key=$kapikey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;

      final trailer = results.firstWhere(
        (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => null,
      );

      if (trailer != null) {
        return trailer['key'];
      }
    }

    return null; // No trailer found or error
  }
}
