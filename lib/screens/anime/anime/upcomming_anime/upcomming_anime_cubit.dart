import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';

part 'upcomming_anime_state.dart';

class UpcommingAnimeCubit extends Cubit<AnimeStates> {
  UpcommingAnimeCubit() : super(AnimeInitial());

  final String apiKey = kapikey;
  List<Map<String, dynamic>>? upcomingAnime;
  bool _animeLoaded = false;

  void showAnime() async {
    if (_animeLoaded) {
      if (!isClosed) emit(AnimeLoaded(upcomingAnime!));
    } else {
      await fetchAndEmit(fetchUpcomingAnime);
    }
  }

  Future<void> fetchAndEmit(Future<bool> Function() fetchFunction) async {
    if (!isClosed) emit(AnimeLoading());

    final start = DateTime.now();
    final success = await fetchFunction();
    final elapsed = DateTime.now().difference(start);
    const minShimmerDuration = Duration(milliseconds: 500);

    if (elapsed < minShimmerDuration) {
      await Future.delayed(minShimmerDuration - elapsed);
    }

    if (isClosed) return;

    if (success && upcomingAnime != null && upcomingAnime!.isNotEmpty) {
      emit(AnimeLoaded(upcomingAnime!));
    } else {
      log('Failed to fetch Anime or empty list');
      emit(AnimeLoadingFailed());
    }
  }

  Future<bool> fetchUpcomingAnime() async {
    try {
      final url =
          '$kbaseurl/discover/tv?api_key=$apiKey&with_genres=16&with_original_language=ja&first_air_date.gte=2025-07-22';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List<dynamic>;

        upcomingAnime = results
            .map<Map<String, dynamic>>(
              (tv) => {
                'posterPath': tv['poster_path']?.toString() ?? '',
                'movieId': tv['id'] ?? 0,
                'contentType': 'tv',
              },
            )
            .where((tv) => (tv['posterPath'] as String).isNotEmpty)
            .toList();

        _animeLoaded = true;
        return true;
      }
    } catch (e) {
      log('Error fetching Anime: $e');
    }
    return false;
  }
}
