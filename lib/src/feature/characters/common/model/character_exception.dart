import 'package:meta/meta.dart';
import 'package:rick_and_morty/src/core/common/localizable.dart';
import 'package:rick_and_morty/src/core/constant/localization/app_localization.dart';

@immutable
sealed class CharacterException implements Localizable, Exception {
  const CharacterException();
}

class CharacterNotFoundException extends CharacterException {
  const CharacterNotFoundException({
    required this.id,
  });

  final int id;

  @override
  String localize(AppLocalization localization) => localization.characterNotFound;
}
