import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/gernes/genre_service.dart';

part 'trending_tv_shows_state.dart';

class TrendingTvShowsCubit extends Cubit<TrendingTvShowsState> {
  TrendingTvShowsCubit() : super(TrendingTvInitial());
    Future<void> fetchTrendingTvShows({int page = 1}) async {
    emit(TrendingTvLoading());

    try {
      final genreService = GenreService();
      final genreMap = await genreService.fetchGenres(contentType: 'movie');

      final response = await http.get(
        Uri.parse(
          '$kbaseurl/trending/tv/day?api_key=$kapikey&page=$page&language=en-US',
        ),
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

        emit(TrendingTvLoaded(movies: movies));
      } else {
        emit(TrendingTvFailed(
          errorMessage:
              'Failed to load trending Tv Shows. Code: ${response.statusCode}',
        ));
      }
    } catch (e) {
      emit(TrendingTvFailed(
        errorMessage: 'Error occurred: ${e.toString()}',
      ));
    }
  }
}
