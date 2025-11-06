import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_mage/core/widgets/gradient.dart';

class BackDropSection extends StatelessWidget {
  final String backdropPath;

  const BackDropSection({super.key, required this.backdropPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (backdropPath.isNotEmpty)
            CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/original$backdropPath',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.blueGrey),
              errorWidget: (context, url, error) => Image.asset(
                'assets/empty image .jpg',
                fit: BoxFit.cover,
              ),
            )
          else
            Image.asset(
              'assets/empty image .jpg',
              fit: BoxFit.cover,
            ),
          const ImageGradient(),
        ],
      ),
    );
  }
}