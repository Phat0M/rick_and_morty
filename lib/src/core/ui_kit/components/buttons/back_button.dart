import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/core/ui_kit/theme/colors_palette.dart';

class UiBackButton extends StatelessWidget {
  const UiBackButton({
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;

    return IconButton(
      onPressed: () {
        (onTap ?? Navigator.of(context).pop).call();
      },
      color: palette.foreground,
      icon: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: const Center(child: Icon(Icons.arrow_back)),
      ),
    );
  }
}
