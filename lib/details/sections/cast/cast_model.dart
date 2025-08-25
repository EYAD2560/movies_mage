class CastModel {
  final int id; // ✅ Add this
  final String name;
  final String character;
  final String? profilePath;

  CastModel({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] ?? 0, // ✅ Assign it from JSON
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      profilePath: json['profile_path'],
    );
  }
}

class DirectorModel {
  final int id; // Add this
  final String name;
  final String? profilePath;

  DirectorModel({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  factory DirectorModel.fromJson(Map<String, dynamic> json) {
    return DirectorModel(
      id: json['id'] ?? 0, // Parse the id
      name: json['name'] ?? 'Unknown',
      profilePath: json['profile_path'],
    );
  }
}

