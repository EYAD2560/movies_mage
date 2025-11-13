import 'package:flutter/material.dart';
import 'package:movies_mage/core/global_model.dart';

class Overview extends StatelessWidget {
  const Overview({
    super.key,
    required this.model,
  });

  final GlobalModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          model.overview,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

