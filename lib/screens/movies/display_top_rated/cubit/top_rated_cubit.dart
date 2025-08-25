import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/widgets/gernes/genre_service.dart';

part 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  TopRatedCubit() : super(TopRatedInitial());
    Future<void> fetchTopRatedMovies({int page = 1}) async {
      emit(TopRatedLoading());

      try {
        final genreService = GenreService();
        final genreMap = await genreService.fetchGenres();

        final response = await http.get(
          Uri.parse('$kbaseurl/movie/top_rated?api_key=$kapikey&page=$page'),
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

          emit(TopRatedLoaded(movies: movies));
        } else {
          emit(TopRatedFailed(
            errorMessage:
                'Failed to load top rated movies. Code: ${response.statusCode}',
          ));
        }
      } catch (e) {
        emit(TopRatedFailed(
          errorMessage: 'Error occurred: ${e.toString()}',
        ));
      }
    }
}
