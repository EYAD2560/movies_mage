import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/gernes/genre_service.dart' ;
import 'package:movies_mage/features/screens/anime/anime/presentation/manger/popular_cubits/popular_anime_cubit.dart';


class PopularAnimeCubit extends Cubit<PopularAnimeState> {
  PopularAnimeCubit() : super(PopularAnimeInitial());
  Future<void> fetchNowPlayingAnime({int page = 1}) async {
    emit(NowPlayingAnimeLoading());

    try {
      final genreService = GenreService();
      final genreMap = await genreService.fetchGenres();

      final response = await http.get(
        Uri.parse('$kbaseurl/discover/tv?api_key=$kapikey'
            '&with_genres=16'
            '&with_original_language=ja'
            '&sort_by=popularity.desc'
            '&page=$page'),
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

        emit(NowPlayingAnimeLoaded(anime: anime));
      } else {
        emit(NowPlayingAnimeFailed(
          errorMessage:
              'Failed to load now playing anime. Code: ${response.statusCode}',
        ));
      }
    } catch (e) {
      emit(NowPlayingAnimeFailed(
        errorMessage: 'Error occurred: ${e.toString()}',
      ));
    }
  }
}
