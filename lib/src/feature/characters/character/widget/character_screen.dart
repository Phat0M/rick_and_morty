import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/src/core/constant/generated/assets.gen.dart';
import 'package:rick_and_morty/src/core/constant/localization/localization.dart';
import 'package:rick_and_morty/src/core/ui_kit/components/buttons/back_button.dart';
import 'package:rick_and_morty/src/core/ui_kit/theme/colors_palette.dart';
import 'package:rick_and_morty/src/feature/characters/character/store/character_store.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/character.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/gender.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/species.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/status.dart';
import 'package:rick_and_morty/src/feature/initialization/widget/dependencies_scope.dart';

@RoutePage()
class CharacterScreen extends StatefulWidget {
  const CharacterScreen({
    @pathParam required this.id,
    super.key,
  });

  final int id;

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late final CharacterStore _store;

  @override
  void initState() {
    super.initState();

    _store = CharacterStore(
      id: widget.id,
      charactersRepository: DependenciesScope.of(context).charactersContainer.repository,
    )..reload();
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          final theme = Theme.of(context);
          final localization = Localization.of(context);

          switch (_store.fetchingCharacter.status) {
            case FutureStatus.pending:
              return Scaffold(
                appBar: AppBar(
                  leading: const UiBackButton(),
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case FutureStatus.rejected:
              return Scaffold(
                appBar: AppBar(
                  leading: const UiBackButton(),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            localization.loadDataError,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _store.reload,
                        child: Text(localization.reload),
                      ),
                    ],
                  ),
                ),
              );
            case FutureStatus.fulfilled:
              final character = _store.fetchingCharacter.result as Character;
              final palette = theme.colorPalette;

              return Material(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar.large(
                      leading: const UiBackButton(),
                      expandedHeight: 260,
                      flexibleSpace: CachedNetworkImage(
                        imageUrl: character.image.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SliverList.list(
                      children: [
                        _Characteristic(
                          title: Text(localization.name),
                          subtitle: Text(character.name),
                          icon: SvgPicture.asset(
                            Assets.icons.common.information,
                            color: palette.surface,
                          ),
                        ),
                        _Characteristic(
                          title: Text(localization.status),
                          subtitle: Text(
                            character.status?.localize(localization) ?? localization.unknown,
                          ),
                          icon: SvgPicture.asset(
                            switch (character.status) {
                              Status.alive => Assets.icons.liveStatus.alive,
                              Status.dead => Assets.icons.liveStatus.dead,
                              null => Assets.icons.liveStatus.unknown,
                            },
                            color: palette.surface,
                          ),
                        ),
                        _Characteristic(
                          title: Text(localization.species),
                          subtitle: Text(
                            character.species?.localize(localization) ?? localization.unknown,
                          ),
                          icon: SvgPicture.asset(
                            switch (character.species) {
                              Species.human => Assets.icons.species.human,
                              Species.alien => Assets.icons.species.alien,
                              Species.humanoid => Assets.icons.species.alien,
                              Species.poopybutthole => Assets.icons.species.alien,
                              Species.mythologicalCreature => Assets.icons.species.alien,
                              Species.animal => Assets.icons.species.alien,
                              Species.robot => Assets.icons.species.alien,
                              Species.cronenberg => Assets.icons.species.alien,
                              Species.disease => Assets.icons.species.alien,
                              null => Assets.icons.species.alien,
                            },
                            color: palette.surface,
                          ),
                        ),
                        _Characteristic(
                          title: Text(localization.gender),
                          subtitle: Text(
                            character.gender?.localize(localization) ?? localization.unknown,
                          ),
                          icon: SvgPicture.asset(
                            switch (character.gender) {
                              null => Assets.icons.gender.unknown,
                              Gender.male => Assets.icons.gender.male,
                              Gender.female => Assets.icons.gender.female,
                            },
                            color: palette.surface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
          }
        },
      );
}

class _Characteristic extends StatelessWidget {
  const _Characteristic({
    required this.title,
    required this.subtitle,
    required this.icon,
    super.key,
  });

  final Widget title;
  final Widget subtitle;
  final Widget icon;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: SizedBox.square(
          dimension: 40,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorPalette.primary,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: icon,
            ),
          ),
        ),
        title: title,
        subtitle: subtitle,
      );
}
