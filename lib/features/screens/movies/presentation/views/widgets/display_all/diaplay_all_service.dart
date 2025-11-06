import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/gernes/genre_service.dart';

class DisplayAllService {

  Future<List<GlobalModel>> fetchAllMovies({int page = 1}) async {
  final genreService = GenreService();
  final genreMap = await genreService.fetchGenres();

  final response = await http.get(Uri.parse(
    '$kbaseurl/discover/movie?api_key=$kapikey&page=$page',
  ));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final results = data['results'];

    return results.map<GlobalModel>((json) {
      List<dynamic> genreIds = json['genre_ids'] ?? [];
      List<String> genreNames =
          genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
      return GlobalModel.fromJson(json, genreNames);
    }).toList();
  } else {
    throw Exception('Failed to fetch all movies');
  }
}

}
