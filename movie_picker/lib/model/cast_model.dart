class CastModel {
  final int id;
  final String name;
  final String character;
  final String? profilePath;

  CastModel({
    required this.id,
    required this.name,
    required this.character,
    this.profilePath,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'], 
      name: json['name'] ?? 'Nome Indisponível',
      character: json['character'] ?? 'Nome indisponível',
      profilePath: json['profile_path'] , 
    );
  }
}
