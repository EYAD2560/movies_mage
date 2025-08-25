import 'package:flutter/material.dart';
import 'package:movies_mage/core/global_model.dart';
class RateandReleasedata extends StatelessWidget {
  const RateandReleasedata({
    super.key,
    required this.model,
  });

  final GlobalModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (model.rate != "0.0") ...[
          Text(
            '${model.rate} ',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const Icon(Icons.star,
              color: Colors.yellow, size: 20),
          const SizedBox(width: 10),
        ],
        if (model.releaseDate.isNotEmpty)
          Text(
            model.releaseDate.split('-').first,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
      ],
    );
  }
}


