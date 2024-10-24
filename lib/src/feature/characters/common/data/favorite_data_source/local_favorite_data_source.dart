import 'dart:convert';

import 'package:rick_and_morty/src/core/collection/immutable_list.dart';
import 'package:rick_and_morty/src/core/utils/key_value_storage/key_value_storage.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/favorite_data_source/favorite_data_source.dart';

class LocalFavoriteDataSource implements FavoriteDataSource {
  LocalFavoriteDataSource({
    required KeyValueStorage storage,
  }) : _favoriteEntry = TypedEntry<String>(
          storage: storage,
          key: 'characters.favorite',
        ).convertable(
          fromBase: (value) => (jsonDecode(value) as List).map((item) => item as int).toSet(),
          toBase: (value) => jsonEncode(value.toList()),
        );

  final StorableEntry<Set<int>> _favoriteEntry;

  @override
  Future<IList<int>> favoriteIndexes() =>
      _favoriteEntry.read().then((value) => value?.toIList() ?? <int>[].lock);

  @override
  Future<void> update(int id, {required bool value}) async {
    final data = await _favoriteEntry.read() ?? {};

    if (value) {
      data.add(id);
    } else {
      data.remove(id);
    }

    await _favoriteEntry.write(data);
  }
}
