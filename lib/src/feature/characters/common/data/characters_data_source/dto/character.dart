import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/characters_data_source/dto/location.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/gender.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/species.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/status.dart';

part 'character.g.dart';

@JsonSerializable()
class CharacterDto {
  const CharacterDto({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  final int id;
  final String name;
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final Status? status;
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final Species? species;
  final String type;
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final Gender? gender;
  final LocationDto origin;
  final LocationDto location;
  final Uri image;
  final List<Uri> episode;
  final Uri url;
  final DateTime created;

  factory CharacterDto.fromJson(Map<String, Object?> json) => _$CharacterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterDtoToJson(this);
}
