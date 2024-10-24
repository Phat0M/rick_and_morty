import 'package:rick_and_morty/src/core/common/pagination/paginated_response.dart';
import 'package:rick_and_morty/src/core/rest_client/rest_client.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/characters_data_source/characters_data_source.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/characters_data_source/dto/character.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/character_exception.dart';

class RemoteCharactersDataSource implements CharactersDataSource {
  RemoteCharactersDataSource({
    required RestClient client,
  }) : _client = client;

  final RestClient _client;

  @override
  Future<CharacterDto> fetch(int id) async {
    final result = await _client.get('character/$id');

    if (result == null) {
      throw CharacterNotFoundException(id: id);
    }

    return CharacterDto.fromJson(result);
  }

  @override
  Future<PaginatedResponse<CharacterDto>> fetchPage(int page) async {
    final result = await _client.get(
      'character',
      queryParams: {
        'page': page.toString(),
      },
    );

    return PaginatedResponse.fromJson(
      result!,
      (json) => CharacterDto.fromJson(json! as Map<String, Object?>),
    );
  }
}
