import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/gernes/genre_service.dart';

class NowPlayingService {

  Future<List<GlobalModel>> fetchNowPlayingMovies({int page = 1}) async {
    final genreService = GenreService();
    final genreMap = await genreService.fetchGenres();

    final response = await http.get(
      Uri.parse('$kbaseurl/movie/now_playing?api_key=$kapikey&page=$page'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'];

      return results.map<GlobalModel>((json) {
        final genreIds = json['genre_ids'] ?? [];
        final genreNames = genreService.mapGenreIds(genreIds, genreMap);
        return GlobalModel.fromJson(json, genreNames);
      }).toList();
    } else {
      throw Exception('Failed to fetch now playing movies');
    }
  }
}
