import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/gernes/genre_service.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit() : super(NowPlayingInitial());
   Future<void> fetchNowPlayingMovies({int page = 1}) async {
      emit(NowPlayingLoading());

      try {
        final genreService = GenreService();
        final genreMap = await genreService.fetchGenres();

        final response = await http.get(
          Uri.parse('$kbaseurl/movie/now_playing?api_key=$kapikey&page=$page'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          List results = data['results'];

          final movies = results.map((json) {
            List<dynamic> genreIds = json['genre_ids'] ?? [];
            List<String> genreNames =
                genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
            return GlobalModel.fromJson(json, genreNames);
          }).toList();

          emit(NowPlayingLoaded(movies: movies));
        } else {
          emit(NowPlayingFailed(
            errorMessage:
                'Failed to load now playing movies. Code: ${response.statusCode}',
          ));
        }
      } catch (e) {
        emit(NowPlayingFailed(
          errorMessage: 'Error occurred: ${e.toString()}',
        ));
      }
    }
}
