import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/gender.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/species.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/status.dart';

@immutable
class Character {
  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.isFavorite,
  });

  final int id;
  final String name;
  final Status? status;
  final Species? species;
  final String? type;
  final Gender? gender;
  final String origin;
  final String location;
  final Uri image;
  final bool isFavorite;

  @factory
  Character update({required bool isFavorite}) => Character(
        id: id,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
        origin: origin,
        location: location,
        image: image,
        isFavorite: isFavorite,
      );

  @override
  String toString() => '$Character('
      'id: $id, '
      'name: $name, '
      'status: $status, '
      'species: $species, '
      'type: $type, '
      'gender: $gender, '
      'origin: $origin, '
      'location: $location, '
      'image: $image, '
      'isFavorite: $isFavorite'
      ')';
}
