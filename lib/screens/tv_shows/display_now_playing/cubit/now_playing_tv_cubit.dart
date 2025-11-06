import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/gernes/genre_service.dart';

part 'now_playing_tv_state.dart';

class NowPlayingTvCubit extends Cubit<NowPlayingTvState> {
  NowPlayingTvCubit() : super(NowPlayingTvInitial());
    Future<void> fetchAiringShows({int page = 1}) async {
    emit(AiringTVLoading());

    try {
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

        final shows = results.map((json) {
          List<dynamic> genreIds = json['genre_ids'] ?? [];
          List<String> genreNames =
              genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
          return GlobalModel.fromJson(json, genreNames);
        }).toList();

        emit(AiringTVLoaded(shows: shows));
      } else {
        emit(AiringTVFailed(
          errorMessage:
              'Failed to load airing shows. Code: ${response.statusCode}',
        ));
      }
    } catch (e) {
      emit(AiringTVFailed(errorMessage: 'Error: ${e.toString()}'));
    }
  }
}
