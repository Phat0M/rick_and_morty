import 'package:meta/meta.dart';
import 'package:rick_and_morty/src/core/common/pagination/paginated_data.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/characters_data_source/characters_data_source.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/characters_data_source/dto/character.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/favorite_data_source/favorite_data_source.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/character.dart';

abstract interface class CharactersRepository {
  Future<PaginatedData<Character>> fetch(int page);

  Future<Character> fetchById(int id);

  Future<void> markFavorite(
    int id, {
    required bool value,
  });
}

class CharactersRepositoryImpl implements CharactersRepository {
  CharactersRepositoryImpl({
    required FavoriteDataSource favoriteDataSource,
    required CharactersDataSource charactersDataSource,
  })  : _favoriteDataSource = favoriteDataSource,
        _charactersDataSource = charactersDataSource;

  final FavoriteDataSource _favoriteDataSource;
  final CharactersDataSource _charactersDataSource;

  @override
  Future<Character> fetchById(int id) async {
    final (characterFuture, favoritesFuture) = (
      _charactersDataSource.fetch(id),
      _favoriteDataSource.favoriteIndexes(),
    );

    final (character, favorites) = (await characterFuture, await favoritesFuture);

    return _buildCharacter(
      character,
      isFavorite: favorites.contains(character.id),
    );
  }

  @override
  Future<PaginatedData<Character>> fetch(int page) async {
    final (charactersFuture, favoritesFuture) = (
      _charactersDataSource.fetchPage(page),
      _favoriteDataSource.favoriteIndexes(),
    );

    final (characters, favorites) = (await charactersFuture, await favoritesFuture);

    return PaginatedData.fromResponse(
      characters,
      page: page,
      converter: (item) => _buildCharacter(
        item,
        isFavorite: favorites.contains(item.id),
      ),
    );
  }

  @override
  Future<void> markFavorite(
    int id, {
    required bool value,
  }) async {
    await _favoriteDataSource.update(id, value: value);
  }

  @factory
  Character _buildCharacter(
    CharacterDto dto, {
    required bool isFavorite,
  }) =>
      Character(
        id: dto.id,
        name: dto.name,
        status: dto.status,
        species: dto.species,
        type: dto.type.isEmpty ? null : dto.type,
        gender: dto.gender,
        origin: dto.origin.name,
        location: dto.location.name,
        image: dto.image,
        isFavorite: isFavorite,
      );
}
