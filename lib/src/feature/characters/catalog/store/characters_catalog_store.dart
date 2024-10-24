import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/src/core/collection/immutable_list.dart';
import 'package:rick_and_morty/src/core/common/pagination/pages_data.dart';
import 'package:rick_and_morty/src/core/common/pagination/paginated_data.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/characters_repository.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/character.dart';

part 'characters_catalog_store.g.dart';

class CharactersCatalogStore = _CharactersCatalogStore with _$CharactersCatalogStore;

abstract class _CharactersCatalogStore with Store {
  _CharactersCatalogStore({required CharactersRepository charactersRepository})
      : _charactersRepository = charactersRepository;

  final CharactersRepository _charactersRepository;

  @observable
  PagesData<Character>? pages;

  @observable
  Object? updateFavoriteException;

  int get _nextPage => (pages?.count ?? 0) + 1;

  @observable
  ObservableFuture<PaginatedData<Character>> fetchingCharacters =
      ObservableFuture.value(PaginatedData.initial());

  @action
  Future<void> updateFavorite(
    Character character, {
    required bool value,
  }) async {
    try {
      await _charactersRepository.markFavorite(character.id, value: value);

      final pages = this.pages;
      if (pages == null) {
        return;
      }

      final coordinates = _findCoordinates(character, pages);
      if (coordinates == null) {
        return;
      }

      final newPages = List.of(pages.pages);

      final updatablePageContent = List.of(newPages[coordinates.page].data);
      updatablePageContent[coordinates.index] = character.update(isFavorite: value);

      newPages[coordinates.page] = newPages[coordinates.page].copyWith(
        data: updatablePageContent.lock,
      );

      this.pages = PagesData(newPages);
    } on Object catch (error) {
      updateFavoriteException = error;

      rethrow;
    }
  }

  ({int page, int index})? _findCoordinates(Character character, PagesData<Character> data) {
    for (var i = 0; i < data.count; i++) {
      final page = data.pages[i];

      for (var j = 0; j < page.data.length; j++) {
        if (page.data[j] == character) {
          return (page: i, index: j);
        }
      }
    }

    return null;
  }

  @action
  void reload() {
    fetchingCharacters = ObservableFuture(
      _charactersRepository.fetch(1).then(
        (page) {
          pages = PagesData([page]);

          return page;
        },
      ),
    );
  }

  @action
  void loadMore() {
    fetchingCharacters.match(
      fulfilled: (_) {
        fetchPage(_nextPage);
      },
      rejected: (error) {
        fetchPage(_nextPage);
      },
    );
  }

  Future<void> fetchPage(int page) async {
    fetchingCharacters = ObservableFuture(
      _charactersRepository.fetch(page).then(
        (page) {
          pages = pages?.applyPage(page) ?? PagesData([page]);

          return page;
        },
      ),
    );
  }
}
