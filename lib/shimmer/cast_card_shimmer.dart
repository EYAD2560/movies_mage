import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CastCardShimmer extends StatelessWidget {
  const CastCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Container(
        height: 100,
        width: 250,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey,
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 18, width: double.infinity, color: Colors.grey),
                    const SizedBox(height: 8),
                    Container(height: 14, width: 100, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
