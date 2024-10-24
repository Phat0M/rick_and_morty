import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/src/core/common/pagination/pages_data.dart';
import 'package:rick_and_morty/src/core/constant/localization/localization.dart';
import 'package:rick_and_morty/src/feature/characters/catalog/store/characters_catalog_store.dart';
import 'package:rick_and_morty/src/feature/characters/catalog/widget/character_card.dart';
import 'package:rick_and_morty/src/feature/characters/catalog/widget/next_page_loader.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/character.dart';
import 'package:rick_and_morty/src/feature/initialization/widget/app_router.dart';
import 'package:rick_and_morty/src/feature/initialization/widget/dependencies_scope.dart';

@RoutePage()
class CharactersCatalogScreen extends StatefulWidget {
  const CharactersCatalogScreen({
    super.key,
  });

  @override
  State<CharactersCatalogScreen> createState() => _CharactersCatalogScreenState();
}

class _CharactersCatalogScreenState extends State<CharactersCatalogScreen> {
  late final _store = CharactersCatalogStore(
    charactersRepository: DependenciesScope.of(context).charactersContainer.repository,
  )..reload();

  late final VoidCallback disposeErrorShower;
  late final localization = Localization.of(context);

  @override
  void initState() {
    super.initState();

    disposeErrorShower = reaction(
      (_) => _store.updateFavoriteException,
      (error) {
        if (error != null) {
          _showError(error);
        }
      },
    );
  }

  void _showError(Object error) {
    final theme = Theme.of(context);

    final snackBar = SnackBar(
      content: Text(localization.updateFavoriteError),
      backgroundColor: theme.colorScheme.error,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    super.dispose();
    disposeErrorShower();
  }

  @override
  Widget build(BuildContext context) => Provider.value(
        value: _store,
        child: Material(
          child: RefreshIndicator(
            onRefresh: () async {
              _store.reload();

              await _store.fetchingCharacters;
            },
            child: Observer(
              builder: (_) {
                final theme = Theme.of(context);

                if (_store.pages case final PagesData<Character> pages) {
                  switch (_store.fetchingCharacters.status) {
                    case FutureStatus.pending:
                      return CharactersSheet(
                        characters: pages.data.toList(),
                        canLoadMore: pages.hasMore,
                        onLoadMore: _store.loadMore,
                      );
                    case FutureStatus.rejected:
                      return CharactersSheet(
                        characters: pages.data.toList(),
                        canLoadMore: false,
                        onLoadMore: _store.loadMore,
                      );
                    case FutureStatus.fulfilled:
                      return CharactersSheet(
                        characters: pages.data.toList(),
                        canLoadMore: pages.hasMore,
                        onLoadMore: _store.loadMore,
                      );
                  }
                } else {
                  switch (_store.fetchingCharacters.status) {
                    case FutureStatus.pending:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case FutureStatus.rejected:
                      return Padding(
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
                      );
                    case FutureStatus.fulfilled:
                      return Text(localization.emptyData);
                  }
                }
              },
            ),
          ),
        ),
      );
}

class CharactersSheet extends StatelessWidget {
  const CharactersSheet({
    required this.characters,
    required this.canLoadMore,
    required this.onLoadMore,
    super.key,
  });

  final List<Character> characters;
  final VoidCallback onLoadMore;
  final bool canLoadMore;

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: MediaQuery.paddingOf(context) + const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                childAspectRatio: 160 / 215,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) => CharacterCard(
                character: characters[index],
                onTap: () => context.router.push(
                  CharacterRoute(id: characters[index].id),
                ),
                updateFavorite: (value) {
                  final store = context.read<CharactersCatalogStore>();

                  store.updateFavorite(
                    characters[index],
                    value: value,
                  );
                },
              ),
            ),
          ),
          if (canLoadMore)
            SliverToBoxAdapter(
              child: NextPageLoader(
                key: ValueKey(characters.length),
                loadMore: onLoadMore,
              ),
            ),
        ],
      );
}
