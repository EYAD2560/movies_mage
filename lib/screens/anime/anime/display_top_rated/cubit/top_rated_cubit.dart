import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/widgets/gernes/genre_service.dart';

part 'top_rated_state.dart';

class TopRatedAnimeCubit extends Cubit<TopRatedAnimeState> {
  TopRatedAnimeCubit() : super(TopRatedInitial());
  Future<void> fetchTopRatedAnime({int page = 1}) async {
    emit(TopRatedAnimeLoading());

    try {
      final genreService = GenreService();
      final genreMap = await genreService.fetchGenres();

      final response = await http.get(
        Uri.parse(
            '$kbaseurl/discover/tv?api_key=$kapikey&with_genres=16&page=$page&sort_by=vote_average.desc&vote_count.gte=100'),
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

        emit(TopRatedAnimeLoaded(anime: anime));
      } else {
        emit(TopRatedAnimeFailed(
          errorMessage:
              'Failed to load top rated anime. Code: ${response.statusCode}',
        ));
      }
    } catch (e) {
      emit(TopRatedAnimeFailed(
        errorMessage: 'Error occurred: ${e.toString()}',
      ));
    }
  }
}
