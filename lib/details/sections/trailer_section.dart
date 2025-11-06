import 'package:flutter/material.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/custom_icon.dart';
import 'package:movies_mage/details/sections/trailer/view_treiler.dart';

class TrailerSection extends StatelessWidget {
  const TrailerSection({
    super.key,
    required this.model,
  });

  final GlobalModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ViewTrailer(item: model, contentType: model.mediaType),
        const SizedBox(width: 20),
        const CustomIcon(
          icon: Icon(Icons.download_sharp, color: Colors.white),
        ),
        const SizedBox(width: 10),
        const CustomIcon(
          icon: Icon(Icons.share, color: Colors.white),
        ),
      ],
    );
  }
}
