import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/gernes/genre_service.dart';

class AiringService {
  Future<List<GlobalModel>> fetchAiringShows({int page = 1}) async {
    final genreService = GenreService();
    final genreMap = await genreService.fetchGenres();

    final response = await http.get(
      Uri.parse(
        '$kbaseurl/tv/airing_today?api_key=$kapikey&language=en-US&page=$page&without_genres=16',
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
      throw Exception('Failed to load airing shows');
    }
  }
}
