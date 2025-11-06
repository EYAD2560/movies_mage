import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';

part 'upcomming_movies_state.dart';

class MoviesCubit extends Cubit<UpcommingMoviesStates> {
  MoviesCubit() : super(MoviesInitial());

  final String apiKey = kapikey;
  List<Map<String, dynamic>>? upcomingMovies;
  bool _moviesLoaded = false;

  void showMovies() async {
    if (_moviesLoaded) {
      if (!isClosed) emit(MoviesLoaded(upcomingMovies!));
      return;
    }

    if (!isClosed) emit(MoviesLoading());

    final url = '$kbaseurl/movie/upcoming?api_key=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));

      if (isClosed) return; // 👈 stop if Cubit closed

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List<dynamic>;

        upcomingMovies = results
            .map<Map<String, dynamic>>(
              (movie) => {
                'posterPath': movie['poster_path']?.toString() ?? '',
                'movieId': movie['id'] ?? 0,
                'contentType': 'movie',
              },
            )
            .where((movie) => (movie['posterPath'] as String).isNotEmpty)
            .toList();

        _moviesLoaded = true;
        if (!isClosed) emit(MoviesLoaded(upcomingMovies!));
      } else {
        if (!isClosed) emit(MoviesLoadFailed());
      }
    } catch (e) {
      if (!isClosed) emit(MoviesLoadFailed());
    }
  }
}
