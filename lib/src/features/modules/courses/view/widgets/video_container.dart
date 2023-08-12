import 'dart:developer';

import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerContainer extends StatelessWidget {
  const VideoPlayerContainer({super.key, required this.controller});
  final YoutubePlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(20)),
      child: YoutubePlayerBuilder(
        // key: ,
        player: YoutubePlayer(
            controller: controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: greys200,
          progressColors: const ProgressBarColors(
            playedColor: skipColor,
            handleColor: success900,
          ),
          onEnded: (value){
              log(value.duration.inMinutes.toString());
          },
          onReady: (){
              controller.addListener(() {
                log(controller.value.position.inSeconds.toString());
              });
          },
        ),
        builder: (_,player) => player,
      ),
    );
  }
}
