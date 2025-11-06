import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PersonDetailsShimmer extends StatelessWidget {
  const PersonDetailsShimmer({super.key});

  // Helper for creating placeholder boxes
  Widget _shimmerBox({
    double height = 12,
    double width = double.infinity,
    double radius = 8,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xff20252d), // Same as base color
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Shimmer.fromColors(
          baseColor: const Color(0xff20252d),       // Custom base color
          highlightColor: const Color(0xff22272f),  // Custom highlight color
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      _shimmerBox(height: 40, width: 40, radius: 8),
                      const SizedBox(width: 16),
                      _shimmerBox(height: 25, width: 150),
                    ],
                  ),
                ),

                // Profile + biography
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmerBox(height: 200, width: 130, radius: 12),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          children: List.generate(10, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: _shimmerBox(),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                // Place of Birth
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Center(
                    child: _shimmerBox(height: 20, width: 180),
                  ),
                ),

                // TabBar Placeholder
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(2, (index) {
                      return _shimmerBox(height: 30, width: 80, radius: 20);
                    }),
                  ),
                ),

                // Grid Placeholder
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 9,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      return _shimmerBox(radius: 12);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
