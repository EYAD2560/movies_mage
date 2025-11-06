import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarouseSliderShimmer extends StatelessWidget {
  const CarouseSliderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: const Color(0xff22272f),
      baseColor: const Color(0xff20252d),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey,
        ),
      ),
    );
  }
}
