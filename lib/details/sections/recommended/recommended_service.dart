import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/widgets/gernes/genre_service.dart';

class FetchRecommendedService {
  Future<List<GlobalModel>> fetchRecommended({
    required String contentType, 
    required int id,
    int page = 1,
  }) async {
    final genreService = GenreService();
    final genreMap = await genreService.fetchGenres(contentType: contentType);

    final response = await http.get(
      Uri.parse(
        '$kbaseurl/$contentType/$id/recommendations?api_key=$kapikey&page=$page',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List results = data['results'];

      return results.map((json) {
        List<dynamic> genreIds = json['genre_ids'] ?? [];
        List<String> genreNames = genreIds
            .map((id) => genreMap[id] ?? 'Unknown')
            .toList();
        return GlobalModel.fromJson(json, genreNames);
      }).toList();
    } else {
      throw Exception('Failed to Load Recommended');
    }
  }
}
