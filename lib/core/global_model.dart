class GlobalModel {
  final int id;
  final String name;
  final String overview;
  final String poster;
  final String backdropImage;
  final String releaseDate;
  final String rate;
  final List<String> genres;
  final String mediaType;

  GlobalModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.poster,
    required this.backdropImage,
    required this.releaseDate,
    required this.rate,
    required this.genres,
    required this.mediaType,
  });

  /// ✅ For saving to local storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'poster': poster,
      'backdrop': backdropImage,
      'releaseDate': releaseDate,
      'rate': rate,
      'genres': genres,
      'mediaType': mediaType,
    };
  }

  /// ✅ For restoring from local storage
  factory GlobalModel.fromJson(Map<String, dynamic> json,
      [List<String>? genreNames]) {
    return GlobalModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? json['title'] ?? 'No Title',
      overview: json['overview'] ?? '',
      poster: json['poster'] ?? json['poster_path'] ?? '',
      backdropImage: json['backdrop'] ?? json['backdrop_path'] ?? '', // ✅ added
      releaseDate: json['releaseDate'] ??
          json['release_date'] ??
          json['first_air_date'] ??
          '',
      rate: json['rate']?.toString() ??
          (json['vote_average'] != null
              ? json['vote_average'].toStringAsFixed(1)
              : ''),
      genres: genreNames ?? List<String>.from(json['genres'] ?? []),
      mediaType: json['media_type'] ?? (json['title'] != null ? 'movie' : 'tv'),
    );
  }

  factory GlobalModel.empty() {
    return GlobalModel(
      id: 0,
      name: '',
      overview: '',
      poster: '',
      backdropImage: '',
      releaseDate: '',
      rate: '',
      genres: [],
      mediaType: '',
    );
  }
}
