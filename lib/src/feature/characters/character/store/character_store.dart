import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/characters_repository.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/character.dart';

part 'character_store.g.dart';

class CharacterStore = _CharacterStore with _$CharacterStore;

abstract class _CharacterStore with Store {
  _CharacterStore({
    required int id,
    required CharactersRepository charactersRepository,
  })  : _id = id,
        _charactersRepository = charactersRepository;

  final CharactersRepository _charactersRepository;
  final int _id;

  @observable
  late ObservableFuture<Character> fetchingCharacter = _characterFuture();

  @action
  void reload() {
    fetchingCharacter = _characterFuture();
  }

  ObservableFuture<Character> _characterFuture() =>
      ObservableFuture(_charactersRepository.fetchById(_id));
}
