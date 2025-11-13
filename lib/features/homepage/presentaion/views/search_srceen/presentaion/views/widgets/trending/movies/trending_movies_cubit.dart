import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/gernes/genre_service.dart';
import 'package:movies_mage/features/homepage/presentaion/views/search_srceen/presentaion/views/trending/presentaion/manger/movies/trending_movies_cubit.dart';


class TrendingMoviesCubit extends Cubit<TrendingMoviesState> {
  TrendingMoviesCubit() : super(TrendingMoviesInitial());

  Future<void> fetchTrendingMovies({int page = 1}) async {
    emit(TrendingMoviesLoading());

    try {
      final genreService = GenreService();
      final genreMap = await genreService.fetchGenres(contentType: 'movie');

      final response = await http.get(
        Uri.parse(
          '$kbaseurl/trending/movie/day?api_key=$kapikey&page=$page&language=en-US',
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

        emit(TrendingMoviesLoaded(movies: movies));
      } else {
        emit(TrendingMoviesFailed(
          errorMessage:
              'Failed to load trending movies. Code: ${response.statusCode}',
        ));
      }
    } catch (e) {
      emit(TrendingMoviesFailed(
        errorMessage: 'Error occurred: ${e.toString()}',
      ));
    }
  }

}
