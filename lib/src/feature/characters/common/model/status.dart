import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/src/core/common/localizable.dart';
import 'package:rick_and_morty/src/core/constant/localization/app_localization.dart';

enum Status implements Localizable {
  @JsonValue('Alive')
  alive,
  @JsonValue('Dead')
  dead;

  @override
  String localize(AppLocalization localization) => switch (this) {
        Status.alive => localization.alive,
        Status.dead => localization.dead,
      };
}
