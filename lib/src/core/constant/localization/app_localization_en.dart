import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationEn extends AppLocalization {
  AppLocalizationEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'rick_and_morty';

  @override
  String get characterNotFound => 'Couldn\'t find character';

  @override
  String get loadDataError => 'Failed to load data';

  @override
  String get reload => 'Reload';

  @override
  String get gender => 'Gender';

  @override
  String get species => 'Species';

  @override
  String get status => 'Status';

  @override
  String get updateFavoriteError => 'Something went wrong';

  @override
  String get emptyData => 'There is no content';

  @override
  String get name => 'Name';

  @override
  String get unknown => 'Unknown';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get alive => 'Alive';

  @override
  String get dead => 'Dead';

  @override
  String get human => 'Human';

  @override
  String get alien => 'Alien';

  @override
  String get humanoid => 'Humanoid';

  @override
  String get poopybutthole => 'Poopybutthole';

  @override
  String get mythological => 'Mythological';

  @override
  String get animal => 'Animal';

  @override
  String get robot => 'Robot';

  @override
  String get cronenberg => 'Cronenberg';

  @override
  String get disease => 'Disease';

  @override
  String get mythologicalCreature => 'Mythological Creature';
}
