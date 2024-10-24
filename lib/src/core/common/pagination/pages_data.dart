// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/src/core/collection/immutable_list.dart';
import 'package:rick_and_morty/src/core/common/pagination/paginated_data.dart';

/// Модель, описывающая пагинированные данные.
@immutable
class PagesData<T extends Object> {
  /// Создание [PagesData] на основе входных [pages].
  ///
  /// Из [pages] создастся иммутабельный массив страниц.
  PagesData(
    List<PaginatedData<T>> pages,
  ) : pages = IList(List.of(pages));

  /// Весь список моделей из страниц [pages].
  Iterable<T> get data => pages.expand((page) => page.data);

  /// Количество страниц.
  int get count => pages.length;

  bool get isEmpty => pages.isEmpty;

  /// Есть ли в сторедже больше данных, которые можно подгрузить дополнительно.
  bool get hasMore => pages.lastOrNull?.hasMore ?? true;

  final IList<PaginatedData<T>> pages;

  /// Создает новую модель, обогащенную данными из дополнительной [PaginatedData].
  /// [page] должна быть следующей по порядку.
  PagesData<T> applyPage(PaginatedData<T> page) {
    assert(
      page.number == count + 1,
      'Применяться должна следующая по счету страница',
    );

    return PagesData<T>(
      [...pages, page],
    );
  }

  @override
  String toString() => '$PagesData('
      'count: $count, '
      'hasMore: $hasMore, '
      'pages: $pages'
      ')';
}
