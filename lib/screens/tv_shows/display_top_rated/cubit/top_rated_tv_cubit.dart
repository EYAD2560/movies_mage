import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/widgets/gernes/genre_service.dart';

part 'top_rated_tv_state.dart';

class TopRatedTvCubit extends Cubit<TopRatedTvState> {
  TopRatedTvCubit() : super(TopRatedTvInitial());
    Future<void> fetchTopRatedTvShows({int page = 1}) async {
    emit(TopRatedTVLoading());

    try {
      final genreService = GenreService();
      final genreMap = await genreService.fetchGenres();

      final response = await http.get(
        Uri.parse(
          '$kbaseurl/discover/tv'
          '?api_key=$kapikey'
          '&air_date.gte=2025-07-22'
          '&air_date.lte=2025-07-22'
          '&without_genres=16'
          '&page=$page'
          '&sort_by=popularity.desc',
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

        emit(TopRatedTVLoaded(shows: shows));
      } else {
        emit(TopRatedTVFailed(
          errorMessage:
              'Failed to load top rated shows. Code: ${response.statusCode}',
        ));
      }
    } catch (e) {
      emit(TopRatedTVFailed(errorMessage: 'Error: ${e.toString()}'));
    }
  }
}
