class PersonCreditsModel {
  final List<MediaWork> movies;
  final List<MediaWork> tvShows;
  final List<MediaWork> anime;
  final List<MediaWork> directed;

  PersonCreditsModel({
    required this.movies,
    required this.tvShows,
    required this.anime,
    required this.directed,
  });

  factory PersonCreditsModel.fromJson(Map<String, dynamic> json) {
    final List allCast = json['cast'] ?? [];
    final List allCrew = json['crew'] ?? [];

    // Parse cast entries
    List<MediaWork> castWorks = allCast
        .map((e) => MediaWork.fromJson(e))
        .where((e) => e.posterPath.isNotEmpty)
        .toList();

    // Parse director works from crew with safe filtering
    List<MediaWork> crewWorks = allCrew
        .where((e) {
          final job = (e['job'] ?? '').toString().toLowerCase().trim();
          return job == 'director' &&
              e['poster_path'] != null &&
              (e['media_type'] == 'movie' || e['media_type'] == 'tv');
        })
        .map((e) => MediaWork.fromJson(e, isCrew: true))
        .where((e) => e.id != 0)
        .toSet()
        .toList(); // toSet removes duplicate IDs

    // Categorize cast
    List<MediaWork> movies = castWorks
        .where((e) => e.mediaType == 'movie')
        .toList();
    List<MediaWork> tvShows = castWorks
        .where((e) => e.mediaType == 'tv')
        .toList();
    List<MediaWork> anime = tvShows
        .where(
          (e) =>
              e.title.toLowerCase().contains("anime") ||
              e.originalLanguage.toLowerCase() == 'ja',
        )
        .toList();

    return PersonCreditsModel(
      movies: movies,
      tvShows: tvShows,
      anime: anime,
      directed: crewWorks,
    );
  }
}

class MediaWork {
  final int id;
  final String title;
  final String posterPath;
  final String mediaType;
  final String originalLanguage;
  final double voteAverage;
  final String? job; // Used if crew (e.g., "Director")
  final String? character; // Used if cast (e.g., "Tony Stark")
  final String? overview;
  final String? releaseDate;

  MediaWork({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.voteAverage,
    this.job,
    this.character,
    this.overview,
    this.releaseDate,
  });

  factory MediaWork.fromJson(Map<String, dynamic> json, {bool isCrew = false}) {
    return MediaWork(
      id: json['id'] ?? 0,
      title: json['title'] ?? json['name'] ?? '',
      posterPath: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : '',
      mediaType: json['media_type'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      job: isCrew ? json['job'] : null,
      character: isCrew ? null : json['character'],
      releaseDate: json['release_date'] ?? json['first_air_date'],
      overview: json['overview'],
    );
  }
}

class FullPersonModel {
  final String name;
  final String biography;
  final String profilePath;
  final String placeOfBirth;
  final PersonCreditsModel credits;

  FullPersonModel({
    required this.name,
    required this.biography,
    required this.profilePath,
    required this.placeOfBirth,
    required this.credits,
  });

  factory FullPersonModel.fromJson(
    Map<String, dynamic> detailsJson,
    Map<String, dynamic> creditsJson,
  ) {
    return FullPersonModel(
      name: detailsJson['name'] ?? 'Unknown',
      biography: detailsJson['biography'] ?? '',
      profilePath: detailsJson['profile_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${detailsJson['profile_path']}'
          : '',
      placeOfBirth: detailsJson['place_of_birth'] ?? '',
      credits: PersonCreditsModel.fromJson(creditsJson),
    );
  }
}
