import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonCardArtwork extends StatelessWidget {
  final String imageUrl;
  final String name;

  const PokemonCardArtwork({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: Colors.white54),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.broken_image,
          size: 64,
          color: Colors.white54,
        ),
        fit: BoxFit.contain,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
