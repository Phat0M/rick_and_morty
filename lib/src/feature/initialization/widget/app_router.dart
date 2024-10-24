import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/feature/characters/catalog/widget/characters_catalog_screen.dart';
import 'package:rick_and_morty/src/feature/characters/character/widget/character_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
)
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: CharactersCatalogRoute.page,
        ),
        AutoRoute(
          path: '/:id',
          page: CharacterRoute.page,
        ),
      ];
}
