import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class VideoPlayerContainer extends StatelessWidget {
  const VideoPlayerContainer({super.key, required this.controller});
  final PodPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(20)),
      child: PodVideoPlayer(
        controller: controller,
      ),
    );
  }
}
