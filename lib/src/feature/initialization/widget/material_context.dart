import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/core/constant/localization/localization.dart';
import 'package:rick_and_morty/src/core/ui_kit/theme/app_theme.dart';
import 'package:rick_and_morty/src/core/ui_kit/theme/app_typography.dart';
import 'package:rick_and_morty/src/core/ui_kit/theme/colors_palette.dart';
import 'package:rick_and_morty/src/feature/initialization/widget/app_router.dart';

/// {@template material_context}
/// [MaterialContext] is an entry point to the material context.
///
/// This widget sets locales, themes and routing.
/// {@endtemplate}
class MaterialContext extends StatefulWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});

  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey();

  @override
  State<MaterialContext> createState() => _MaterialContextState();
}

class _MaterialContextState extends State<MaterialContext> {
  final router = AppRouter();

  late final theme = AppThemeFactory(
    typographyFactory: const AppTypographyFactory(),
    colorPaletteFactory: const ColorPaletteFactory(),
  ).create();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        localizationsDelegates: Localization.localizationDelegates,
        supportedLocales: Localization.supportedLocales,
        routerConfig: router.config(),
        theme: theme,
        builder: (context, child) => KeyedSubtree(
          key: MaterialContext._globalKey,
          child: child!,
        ),
      );
}
