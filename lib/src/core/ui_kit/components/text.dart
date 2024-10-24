import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/core/ui_kit/theme/app_typography.dart';
import 'package:rick_and_morty/src/core/ui_kit/theme/colors_palette.dart';

/// {@template ui_text}
/// A widget that displays a string of text with a specific style.
/// {@endtemplate}
class UiText extends StatelessWidget {
  /// {@macro ui_text}
  const UiText(
    this.data, {
    this.color,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    TextStyle? Function(AppTypography)? styleBuilder,
    super.key,
  }) : _styleBuilder = styleBuilder;

  factory UiText.body1(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText(
        data,
        color: color,
        style: style,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        styleBuilder: (typography) => typography.body1,
        key: key,
      );

  factory UiText.body2(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText(
        data,
        color: color,
        style: style,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        styleBuilder: (typography) => typography.body2,
        key: key,
      );

  factory UiText.caption1(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText(
        data,
        color: color,
        style: style,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        styleBuilder: (typography) => typography.caption1,
        key: key,
      );

  factory UiText.caption2(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText(
        data,
        color: color,
        style: style,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        styleBuilder: (typography) => typography.caption2,
        key: key,
      );

  factory UiText.subtitle(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) =>
      UiText(
        data,
        color: color,
        style: style,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        styleBuilder: (typography) => typography.subtitle,
        key: key,
      );

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color? color;
  final TextStyle? Function(AppTypography)? _styleBuilder;

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).appTypography;
    final palette = Theme.of(context).colorPalette;

    final style = _styleBuilder?.call(typography) ?? typography.body1;

    return Text(
      data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: style.copyWith(color: color ?? palette.foreground),
    );
  }
}
