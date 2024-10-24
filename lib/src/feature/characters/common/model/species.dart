import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/src/core/common/localizable.dart';
import 'package:rick_and_morty/src/core/constant/localization/app_localization.dart';

enum Species implements Localizable {
  @JsonValue('Human')
  human,
  @JsonValue('Alien')
  alien,
  @JsonValue('Humanoid')
  humanoid,
  @JsonValue('Poopybutthole')
  poopybutthole,
  @JsonValue('Mythological Creature')
  mythologicalCreature,
  @JsonValue('Animal')
  animal,
  @JsonValue('Robot')
  robot,
  @JsonValue('Cronenberg')
  cronenberg,
  @JsonValue('Disease')
  disease;

  @override
  String localize(AppLocalization localization) => switch (this) {
        Species.human => localization.human,
        Species.alien => localization.alien,
        Species.humanoid => localization.humanoid,
        Species.poopybutthole => localization.poopybutthole,
        Species.mythologicalCreature => localization.mythologicalCreature,
        Species.animal => localization.animal,
        Species.robot => localization.robot,
        Species.cronenberg => localization.cronenberg,
        Species.disease => localization.disease,
      };
}
