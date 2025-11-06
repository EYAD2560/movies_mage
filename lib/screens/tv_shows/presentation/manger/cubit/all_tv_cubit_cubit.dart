import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/gernes/genre_service.dart';
import 'package:movies_mage/screens/tv_shows/presentation/manger/all_tv_cubits/all_tv_cubit_cubit.dart';


class AllTvCubit extends Cubit<AllTvCubitState> {
  AllTvCubit() : super(AllTvCubitInitial());
  Future<void> fetchAllShows({int page = 1}) async {
    emit(AllTVLoading());

    try {
      final genreService = GenreService();
      final genreMap = await genreService.fetchGenres();

      final response = await http.get(
        Uri.parse(
          '$kbaseurl/discover/tv?api_key=$kapikey'
          '&language=en-US&sort_by=popularity.desc&page=$page&without_genres=16',
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

        emit(AllTVLoaded(shows: shows));
      } else {
        emit(AllTVFailed(
          errorMessage:
              'Failed to load TV shows. Code: ${response.statusCode}',
        ));
      }
    } catch (e) {
      emit(AllTVFailed(errorMessage: 'Error: ${e.toString()}'));
    }
  }

}
