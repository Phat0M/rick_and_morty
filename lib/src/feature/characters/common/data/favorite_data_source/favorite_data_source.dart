import 'package:rick_and_morty/src/core/collection/immutable_list.dart';

abstract interface class FavoriteDataSource {
  Future<IList<int>> favoriteIndexes();

  Future<void> update(
    int id, {
    required bool value,
  });
}
