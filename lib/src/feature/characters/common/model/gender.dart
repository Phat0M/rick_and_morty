import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/src/core/common/localizable.dart';
import 'package:rick_and_morty/src/core/constant/localization/app_localization.dart';

enum Gender implements Localizable {
  @JsonValue('Male')
  male,
  @JsonValue('Female')
  female;

  @override
  String localize(AppLocalization localization) => switch (this) {
        Gender.male => localization.male,
        Gender.female => localization.female,
      };
}
