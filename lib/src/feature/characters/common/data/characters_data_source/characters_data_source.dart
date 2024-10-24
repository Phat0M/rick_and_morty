import 'package:rick_and_morty/src/core/common/pagination/paginated_response.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/characters_data_source/dto/character.dart';

abstract interface class CharactersDataSource {
  Future<PaginatedResponse<CharacterDto>> fetchPage(int page);

  Future<CharacterDto> fetch(int id);
}
