// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:meta/meta.dart';
import 'package:rick_and_morty/src/core/collection/immutable_list.dart';
import 'package:rick_and_morty/src/core/common/pagination/paginated_response.dart';

@immutable
class PaginatedData<T extends Object> {
  @factory
  static PaginatedData<T> fromResponse<T extends Object, DTO extends Object>(
    PaginatedResponse<DTO> response, {
    required int page,
    required T Function(DTO) converter,
  }) =>
      PaginatedData(
        data: response.results.map(converter).toIList(),
        number: page,
        hasMore: response.info.next != null,
      );

  const PaginatedData({
    required this.data,
    required this.number,
    required this.hasMore,
  });

  factory PaginatedData.initial() => PaginatedData<T>(
        data: IList([]),
        number: 0,
        hasMore: true,
      );

  final IList<T> data;

  final int number;

  final bool hasMore;

  @factory
  PaginatedData<T> copyWith({
    IList<T>? data,
    int? number,
    bool? hasMore,
  }) =>
      PaginatedData(
        data: data ?? this.data,
        number: number ?? this.number,
        hasMore: hasMore ?? this.hasMore,
      );

  @override
  String toString() => '${PaginatedData<T>}('
      'data: $data, '
      'number: $number, '
      'hasMore: $hasMore'
      ')';
}
