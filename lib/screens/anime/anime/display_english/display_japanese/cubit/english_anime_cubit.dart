import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/gernes/genre_service.dart';

part 'english_anime_state.dart';

class EnglishAnimeCubit extends Cubit<EnglishAnimeState> {
  EnglishAnimeCubit() : super(EnglishAnimeInitial());
    Future<void> fetchEnglishAnime({int page = 1}) async {
    emit(EnglishAnimeLoading());

    try {
      final genreService = GenreService();
      final genreMap = await genreService.fetchGenres();

      final response = await http.get(
        Uri.parse(
            '$kbaseurl/discover/tv?api_key=$kapikey&with_genres=16&with_original_language=en&page=$page'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List results = data['results'];

        final anime = results.map((json) {
          List<dynamic> genreIds = json['genre_ids'] ?? [];
          List<String> genreNames =
              genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
          return GlobalModel.fromJson(json, genreNames);
        }).toList();

        emit(EnglishAnimeLoaded(anime: anime));
      } else {
        emit(EnglishAnimeFailed(
          errorMessage:
              'Failed to load English anime. Code: ${response.statusCode}',
        ));
      }
    } catch (e) {
      emit(EnglishAnimeFailed(
        errorMessage: 'Error occurred: ${e.toString()}',
      ));
    }
  }
}
