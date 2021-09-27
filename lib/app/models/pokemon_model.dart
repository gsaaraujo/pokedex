import 'dart:convert';

class PokemonModel {
  final int id;
  final String name;
  final List<Map<String, dynamic>> types;
  final int height;
  final int weight;
  final List<Map<String, dynamic>> moves;
  final List<Map<String, dynamic>> stats;
  final String sprites;

  PokemonModel({
    required this.id,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
    required this.moves,
    required this.stats,
    required this.sprites,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'types': types,
      'height': height,
      'weight': weight,
      'moves': moves,
      'stats': stats,
      'sprites': sprites,
    };
  }

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      id: map['id'],
      name: map['name'],
      types: List<Map<String, dynamic>>.from(map['types']?.map((x) => x)),
      height: map['height'],
      weight: map['weight'],
      moves: List<Map<String, dynamic>>.from(map['moves']?.map((x) => x)),
      stats: List<Map<String, dynamic>>.from(map['stats']?.map((x) => x)),
      sprites: map['sprites'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonModel.fromJson(String source) =>
      PokemonModel.fromMap(json.decode(source));
}
