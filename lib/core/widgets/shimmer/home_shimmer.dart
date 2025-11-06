import 'package:flutter/material.dart';
import 'package:movies_mage/core/widgets/custom_bar.dart';
import 'package:movies_mage/core/widgets/listviews/movies_shimmer_listview.dart';
import 'package:movies_mage/core/widgets/shimmer/curser_slider_shimmer.dart';

class HomeShimmerScreen extends StatelessWidget {
  const HomeShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            // Slider shimmer with only appbar & tabs stacked on it
            Stack(
              children: [
                const CarouseSliderShimmer(), // Background shimmer

           
              ],
            ),

            // Rest of shimmer content (below the slider)
            Expanded(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Custombar(title: 'Top rated'),
                    ),
                    MoviesCardShimmerListView(),
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
