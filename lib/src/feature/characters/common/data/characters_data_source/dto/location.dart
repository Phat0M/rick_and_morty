import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class LocationDto {
  const LocationDto({
    required this.name,
    required this.url,
  });

  final String name;
  final Uri url;

  factory LocationDto.fromJson(Map<String, dynamic> json) => _$LocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}
