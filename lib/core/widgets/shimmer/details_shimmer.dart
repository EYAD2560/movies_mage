import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailShimmer extends StatelessWidget {
  const DetailShimmer({super.key});

  Widget shimmerContainer({double? width, double? height, BorderRadius? radius}) {
    return Shimmer.fromColors(
      baseColor: const Color(0xff20252d),
      highlightColor: const Color(0xff22272f),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xff20252d),
          borderRadius: radius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // Backdrop shimmer
        shimmerContainer(
          width: double.infinity,
          height: 400,
        ),

        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title shimmer
              shimmerContainer(width: 200, height: 30),

              const SizedBox(height: 12),

              // Rating and year
              Row(
                children: [
                  shimmerContainer(width: 40, height: 20),
                  const SizedBox(width: 8),
                  shimmerContainer(width: 20, height: 20),
                  const SizedBox(width: 20),
                  shimmerContainer(width: 60, height: 20),
                ],
              ),

              const SizedBox(height: 12),

              // Genre chips shimmer
              Row(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: shimmerContainer(
                      width: 60,
                      height: 25,
                      radius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Trailer + icons
              Row(
                children: [
                  shimmerContainer(width: 140, height: 40),
                  const SizedBox(width: 20),
                  shimmerContainer(width: 40, height: 40, radius: BorderRadius.circular(30)),
                  const SizedBox(width: 10),
                  shimmerContainer(width: 40, height: 40, radius: BorderRadius.circular(30)),
                ],
              ),

              const SizedBox(height: 25),

              // Cast shimmer cards
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        shimmerContainer(width: 80, height: 80, radius: BorderRadius.circular(50)),
                        const SizedBox(height: 8),
                        shimmerContainer(width: 60, height: 10),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Overview title
              shimmerContainer(width: 120, height: 25),

              const SizedBox(height: 12),

              // Overview text lines
              shimmerContainer(width: double.infinity, height: 10),
              const SizedBox(height: 6),
              shimmerContainer(width: double.infinity, height: 10),
              const SizedBox(height: 6),
              shimmerContainer(width: MediaQuery.of(context).size.width * 0.7, height: 10),

              const SizedBox(height: 30),

              // Recommended section title
              shimmerContainer(width: 160, height: 20),
              const SizedBox(height: 12),

              // Recommended list shimmer
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: shimmerContainer(width: 120, height: 180),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Reviews section shimmer
              shimmerContainer(width: 140, height: 20),
              const SizedBox(height: 12),
              shimmerContainer(width: double.infinity, height: 60),
              const SizedBox(height: 10),
              shimmerContainer(width: double.infinity, height: 60),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}
