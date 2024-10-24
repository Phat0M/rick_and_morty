import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/core/ui_kit/theme/colors_palette.dart';
import 'package:rick_and_morty/src/core/ui_kit/components/text.dart';
import 'package:rick_and_morty/src/feature/characters/common/model/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    required this.character,
    required this.onTap,
    required this.updateFavorite,
    super.key,
  });

  final Character character;
  final VoidCallback onTap;
  final ValueSetter<bool> updateFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const borderRadius = 20.0;

    return Material(
      color: theme.colorPalette.background,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(borderRadius),
                      ),
                      child: Image(
                        image: imageProvider,
                      ),
                    ),
                    imageUrl: character.image.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: _FavoriteButton(
                    isFavorite: character.isFavorite,
                    updateFavorite: updateFavorite,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: UiText.body1(
                character.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatefulWidget {
  const _FavoriteButton({
    required this.isFavorite,
    required this.updateFavorite,
    super.key,
  });

  final bool isFavorite;
  final ValueSetter<bool> updateFavorite;

  @override
  State<_FavoriteButton> createState() => __FavoriteButtonState();
}

class __FavoriteButtonState extends State<_FavoriteButton> {
  late bool isFavorite = widget.isFavorite;

  @override
  void didUpdateWidget(covariant _FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isFavorite != oldWidget.isFavorite) {
      isFavorite = widget.isFavorite;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;

          widget.updateFavorite(isFavorite);
        });
      },
      alignment: Alignment.center,
      iconSize: 20,
      padding: const EdgeInsets.all(10),
      icon: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorPalette.background,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_outline,
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
