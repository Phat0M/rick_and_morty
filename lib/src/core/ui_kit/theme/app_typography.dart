import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/feature/initialization/logic/composition_root.dart';

class AppTypographyFactory implements Factory<AppTypography> {
  const AppTypographyFactory();

  @override
  AppTypography create() => const AppTypography(
        subtitle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          height: 22.4 / 16,
        ),
        body1: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          height: 19.6 / 14,
        ),
        body2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 19.6 / 14,
        ),
        caption1: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 16.8 / 12,
        ),
        caption2: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 16.8 / 12,
        ),
      );
}

class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.subtitle,
    required this.body1,
    required this.body2,
    required this.caption1,
    required this.caption2,
  });

  final TextStyle subtitle;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle caption1;
  final TextStyle caption2;

  @override
  ThemeExtension<AppTypography> copyWith({
    TextStyle? subtitle,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? caption1,
    TextStyle? caption2,
  }) =>
      AppTypography(
        subtitle: subtitle ?? this.subtitle,
        body1: body1 ?? this.body1,
        body2: body2 ?? this.body2,
        caption1: caption1 ?? this.caption1,
        caption2: caption2 ?? this.caption2,
      );

  @override
  ThemeExtension<AppTypography> lerp(
    covariant ThemeExtension<AppTypography>? other,
    double t,
  ) {
    if (other == null || other is! AppTypography) {
      return this;
    }

    return AppTypography(
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
      body1: TextStyle.lerp(body1, other.body1, t)!,
      body2: TextStyle.lerp(body2, other.body2, t)!,
      caption1: TextStyle.lerp(caption1, other.caption1, t)!,
      caption2: TextStyle.lerp(caption2, other.caption2, t)!,
    );
  }
}

extension AppTypographyExtension on ThemeData {
  AppTypography get appTypography =>
      extension<AppTypography>() ?? const AppTypographyFactory().create();
}
