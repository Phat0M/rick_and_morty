import 'package:meta/meta.dart';
import 'package:rick_and_morty/src/core/rest_client/rest_client.dart';
import 'package:rick_and_morty/src/core/utils/key_value_storage/key_value_storage.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/characters_data_source/remote_characters_data_source.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/characters_repository.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/favorite_data_source/local_favorite_data_source.dart';
import 'package:rick_and_morty/src/feature/initialization/logic/composition_root.dart';

@immutable
class CharactersContainer {
  const CharactersContainer({required this.repository});

  final CharactersRepository repository;
}

final class CharactersContainerFactory implements AsyncFactory<CharactersContainer> {
  CharactersContainerFactory({required this.storage, required this.client});
  final KeyValueStorage storage;
  final RestClient client;

  @override
  Future<CharactersContainer> create() async {
    final charactersRepository = CharactersRepositoryImpl(
      favoriteDataSource: LocalFavoriteDataSource(
        storage: storage,
      ),
      charactersDataSource: RemoteCharactersDataSource(
        client: client,
      ),
    );

    return CharactersContainer(
      repository: charactersRepository,
    );
  }
}
