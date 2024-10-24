import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/core/ui_kit/theme/app_typography.dart';
import 'package:rick_and_morty/src/core/ui_kit/theme/colors_palette.dart';
import 'package:rick_and_morty/src/feature/initialization/logic/composition_root.dart';

class AppThemeFactory implements Factory<ThemeData> {
  AppThemeFactory({
    required this.typographyFactory,
    required this.colorPaletteFactory,
  });

  final Factory<AppTypography> typographyFactory;
  final Factory<ColorPalette> colorPaletteFactory;

  @override
  ThemeData create() {
    final palette = colorPaletteFactory.create();

    final theme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.primary,
        primary: palette.primary,
        surface: palette.surface,
      ),
    );

    return theme.copyWith(
      extensions: [
        palette,
        typographyFactory.create(),
      ],
    );
  }
}
