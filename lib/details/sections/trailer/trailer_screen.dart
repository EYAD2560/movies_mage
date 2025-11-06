import 'package:flutter/material.dart';
import 'package:movies_mage/core/widgets/return_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayerScreen extends StatelessWidget {
  final String youtubeKey;

  const TrailerPlayerScreen({super.key, required this.youtubeKey});

  YoutubePlayerController getController() {
    return YoutubePlayerController(
      initialVideoId: youtubeKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        controlsVisibleAtStart: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = getController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
          ),
          builder: (context, player) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              ReturnButton() ,
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: player,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
