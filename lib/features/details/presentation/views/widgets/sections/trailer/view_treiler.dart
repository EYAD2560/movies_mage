// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:movies_mage/features/details/presentation/views/widgets/sections/trailer/trailer_screen.dart';
import 'package:movies_mage/features/details/presentation/views/widgets/sections/trailer/trailer_service.dart';

class ViewTrailer extends StatelessWidget {
  const ViewTrailer({
    super.key,
    required this.item,
    required this.contentType,
  });

  final dynamic item;
  final String contentType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

        final trailerKey = await TrailerService.fetchTrailerKey(
          item.id,
          type: contentType,
        );


        if (trailerKey != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TrailerPlayerScreen(
                youtubeKey: trailerKey,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Trailer not available')),
          );
        }
      },
      child: Stack(
        children: [
          Container(
            height: 50,
            width: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xff0BA124),
            ),
          ),
          const Positioned(
            right: 35,
            top: 8,
            left: 35,
            child: Row(
              children: [
                Icon(Icons.play_arrow, color: Colors.white, size: 35),
                SizedBox(width: 5),
                Text(
                  "Watch Trailer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
