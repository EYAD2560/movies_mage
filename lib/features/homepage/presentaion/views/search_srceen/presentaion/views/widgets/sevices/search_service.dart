  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:movies_mage/constants.dart';
  import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/gernes/genre_service.dart';

  class SearchService {
    final genreService = GenreService();

    /// Search from API (movies & TV shows only)
    Future<List<GlobalModel>> search(String query) async {
      // Fetch genres for movies and TV
      final genreMovieMap = await genreService.fetchGenres(contentType: 'movie');
      final genreTvMap = await genreService.fetchGenres(contentType: 'tv');

      // Build API URL for multi search
      final url = '$kbaseurl/search/multi?api_key=$kapikey&query=$query&language=en-US';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List results = data['results'];

        // Keep only movies and TV shows
        final filtered = results.where((json) =>
            json['media_type'] == 'movie' || json['media_type'] == 'tv');

        // Convert to GlobalModel with genre names
        return filtered.map<GlobalModel>((json) {
          List<dynamic> genreIds = json['genre_ids'] ?? [];
          final genreMap =
              json['media_type'] == 'movie' ? genreMovieMap : genreTvMap;
          List<String> genreNames =
              genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();

          return GlobalModel.fromJson(json, genreNames);
        }).toList();
      } else {
        throw Exception('Failed to search');
      }
    }

    /// Trending Movies
    Future<List<GlobalModel>> fetchTrendingMovies({int page = 1}) async {
      final genreMap = await genreService.fetchGenres(contentType: 'movie');
      final response = await http.get(
        Uri.parse('$kbaseurl/trending/movie/day?api_key=$kapikey&page=$page&language=en-US'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List results = data['results'];

        return results.map((json) {
          List<dynamic> genreIds = json['genre_ids'] ?? [];
          List<String> genreNames =
              genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
          return GlobalModel.fromJson(json, genreNames);
        }).toList();
      } else {
        throw Exception('Failed to load trending movies');
      }
    }

    /// Trending TV Shows
    Future<List<GlobalModel>> fetchTrendingTvShows({int page = 1}) async {
      final genreMap = await genreService.fetchGenres(contentType: 'tv');
      final response = await http.get(
        Uri.parse('$kbaseurl/trending/tv/day?api_key=$kapikey&page=$page&language=en-US'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List results = data['results'];

        return results.map((json) {
          List<dynamic> genreIds = json['genre_ids'] ?? [];
          List<String> genreNames =
              genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
          return GlobalModel.fromJson(json, genreNames);
        }).toList();
      } else {
        throw Exception('Failed to load trending TV shows');
      }
    }

    /// Movies by Genre
    Future<List<GlobalModel>> fetchMoviesCategory({
      required int page,
      required int categoryId,
    }) async {
      final genreMap = await genreService.fetchGenres(contentType: 'movie');
      final response = await http.get(
        Uri.parse('$kbaseurl/discover/movie?api_key=$kapikey&with_genres=$categoryId&page=$page&language=en-US'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List results = data['results'];

        return results.map((json) {
          List<dynamic> genreIds = json['genre_ids'] ?? [];
          List<String> genreNames =
              genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
          return GlobalModel.fromJson(json, genreNames);
        }).toList();
      } else {
        throw Exception('Failed to load category movies');
      }
    }

    /// TV Shows by Genre
    Future<List<GlobalModel>> fetchTvCategory({
      required int page,
      required int categoryId,
    }) async {
      final genreMap = await genreService.fetchGenres(contentType: 'tv');
      final response = await http.get(
        Uri.parse('$kbaseurl/discover/tv?api_key=$kapikey&with_genres=$categoryId&page=$page&language=en-US'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List results = data['results'];

        return results.map((json) {
          List<dynamic> genreIds = json['genre_ids'] ?? [];
          List<String> genreNames =
              genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
          return GlobalModel.fromJson(json, genreNames);
        }).toList();
      } else {
        throw Exception('Failed to load category TV shows');
      }
    }
  }
