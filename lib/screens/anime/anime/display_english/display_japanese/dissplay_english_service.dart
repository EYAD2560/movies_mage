import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/widgets/gernes/genre_service.dart';
import 'package:movies_mage/core/global_model.dart';

class DisplayAllenglishAnimeService {

  Future<List<GlobalModel>> fetchAllenglishAnime({int page = 1}) async {
  final genreService = GenreService();
  final genreMap = await genreService.fetchGenres();

  final response = await http.get(
    Uri.parse(
      '$kbaseurl/discover/tv?api_key=$kapikey&with_genres=16&with_original_language=en&page=$page',
    ),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List results = data['results'];
    return results.map((json) {
      List<dynamic> genreIds = json['genre_ids'] ?? [];
      List<String> genreNames =
          genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();

      return GlobalModel.fromJson(json, genreNames);
    }).toList();
  } else {
    throw Exception('Failed to load English anime');
  }
}

}
