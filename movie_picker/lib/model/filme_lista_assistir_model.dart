class FilmeListaAssistirModel {
  int id;
  String nomeFilme;
  String posterPath;
  int isAssistido;
  bool? isAssistidoBool;
  
  FilmeListaAssistirModel({
    required this.id,
    required this.nomeFilme,
    required this.posterPath,
    required this.isAssistido,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeFilme': nomeFilme,
      'posterPath': posterPath,
      'isAssistido': isAssistido,
    };
  }

  factory FilmeListaAssistirModel.fromMap(Map<String, dynamic> map) {
    return FilmeListaAssistirModel(
      id: map['id'],
      nomeFilme: map['nomeFilme'],
      posterPath: map['posterPath'],
      isAssistido: map['isAssistido'],
    );
  }
}
