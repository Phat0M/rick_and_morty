import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/feature/initialization/logic/composition_root.dart';

class ColorPaletteFactory implements Factory<ColorPalette> {
  const ColorPaletteFactory();

  @override
  ColorPalette create() => const ColorPalette(
        surface: Color(0xFFF8F8F8),
        background: Color(0xFFFFFFFF),
        primary: Color(0xFF11B0C8),
        foreground: Color(0xFF1F1F1F),
        secondaryForeground: Color(0xFF808080),
      );
}

class ColorPalette extends ThemeExtension<ColorPalette> {
  const ColorPalette({
    required this.surface,
    required this.background,
    required this.primary,
    required this.foreground,
    required this.secondaryForeground,
  });

  /// # whiteSmoke
  final Color surface;

  /// # white
  final Color background;

  /// # irisBlue
  final Color primary;

  /// # nero
  final Color foreground;

  /// # gray
  final Color secondaryForeground;

  @override
  ThemeExtension<ColorPalette> copyWith({
    Color? surface,
    Color? background,
    Color? primary,
    Color? foreground,
    Color? secondaryForeground,
  }) =>
      ColorPalette(
        surface: surface ?? this.surface,
        background: background ?? this.background,
        primary: primary ?? this.primary,
        foreground: foreground ?? this.foreground,
        secondaryForeground: secondaryForeground ?? this.secondaryForeground,
      );

  @override
  ThemeExtension<ColorPalette> lerp(
    covariant ThemeExtension<ColorPalette>? other,
    double t,
  ) {
    if (other == null || other is! ColorPalette) {
      return this;
    }

    return ColorPalette(
      surface: Color.lerp(surface, other.surface, t)!,
      background: Color.lerp(background, other.background, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      secondaryForeground: Color.lerp(secondaryForeground, other.secondaryForeground, t)!,
    );
  }
}

extension ColorPaletteExtension on ThemeData {
  ColorPalette get colorPalette =>
      extension<ColorPalette>() ?? const ColorPaletteFactory().create();
}
