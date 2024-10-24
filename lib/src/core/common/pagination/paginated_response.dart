import 'package:json_annotation/json_annotation.dart';

part 'paginated_response.g.dart';

@JsonSerializable(
  includeIfNull: false,
  genericArgumentFactories: true,
  explicitToJson: true,
)
class PaginatedResponse<T> {
  final PageInfo info;
  final List<T> results;

  PaginatedResponse({
    required this.info,
    required this.results,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$PaginatedResponseToJson(this, toJsonT);
}

@JsonSerializable()
class PageInfo {
  final int count;
  final int pages;
  final Uri? next;
  final Uri? prev;

  PageInfo({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => _$PageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoToJson(this);
}
