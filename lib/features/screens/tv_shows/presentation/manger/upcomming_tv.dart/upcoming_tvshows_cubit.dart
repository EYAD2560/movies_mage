import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';

part 'upcoming_tvshows_state.dart';

class UpcomingTvshowsCubit extends Cubit<TvShowsStates> {
  UpcomingTvshowsCubit() : super(TvShowsInitial());

  final String apiKey = kapikey;
  List<Map<String, dynamic>>? upcomingTvShows;
  bool _tvShowsLoaded = false;

  void showTvShows() async {
    if (_tvShowsLoaded) {
      if (!isClosed) emit(TvShowsLoaded(upcomingTvShows!));
    } else {
      await _fetchAndEmit(fetchUpcomingTvShows);
    }
  }

  Future<void> _fetchAndEmit(Future<bool> Function() fetchFunction) async {
    if (!isClosed) emit(TvShowsLoading());

    final start = DateTime.now();
    final success = await fetchFunction();
    final elapsed = DateTime.now().difference(start);
    const minShimmerDuration = Duration(milliseconds: 500);

    if (elapsed < minShimmerDuration) {
      await Future.delayed(minShimmerDuration - elapsed);
    }

    if (isClosed) return; // 👈 prevent emit after close

    if (success && upcomingTvShows != null && upcomingTvShows!.isNotEmpty) {
      emit(TvShowsLoaded(upcomingTvShows!));
    } else {
      log('Failed to fetch TV shows or empty list');
      emit(TvShowsLoadingFailed());
    }
  }

  Future<bool> fetchUpcomingTvShows() async {
    try {
      final url =
          '$kbaseurl/tv/on_the_air?api_key=$apiKey&without_genres=16,10762';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List<dynamic>;

        upcomingTvShows = results
            .where((tv) {
              final originCountries =
                  (tv['origin_country'] as List<dynamic>? ?? [])
                      .map((e) => e.toString())
                      .toList();
              return !originCountries.contains('JP');
            })
            .map<Map<String, dynamic>>(
              (tv) => {
                'posterPath': tv['poster_path']?.toString() ?? '',
                'movieId': tv['id'] ?? 0,
                'contentType': 'tv',
              },
            )
            .where((tv) => (tv['posterPath'] as String).isNotEmpty)
            .toList();

        _tvShowsLoaded = true;
        return true;
      }
    } catch (e) {
      log('Error fetching TV shows: $e');
    }
    return false;
  }
}
