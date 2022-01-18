import 'package:flat_and_fast/common/controls/video/video_player_widget.dart';
import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const preferredVideoHeight = 300.0;
const videoBottomContentHeight = 40.0;
const controlBarHeight = 20.0;
const avatarRadius = 20.0;

class ConstrainedVideoPlayer extends StatefulWidget {
  const ConstrainedVideoPlayer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoPlayerController? controller;

  @override
  _ConstrainedVideoPlayerState createState() => _ConstrainedVideoPlayerState();
}

class _ConstrainedVideoPlayerState extends State<ConstrainedVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    if (widget.controller == null) return Container();
    VideoPlayerController playerController = widget.controller!;

    double screenHeight = MediaQuery.of(context).size.height;
    var aspectRatio = playerController.value.aspectRatio;

    var isMuted = playerController.value.volume == 0;
    var isPlaying = playerController.value.isPlaying;
    var isLooping = playerController.value.isLooping;

    return Column(
      children: [
        aspectRatio < 1
            ? SizedBox(
                height: screenHeight / 1.5,
                child: VideoPlayerWidget(controller: playerController),
              )
            : VideoPlayerWidget(controller: playerController),
        Builder(builder: (context) {
          if (playerController.value.isInitialized) {
            return SizedBox(
              height: videoBottomContentHeight + controlBarHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: AppColors.dustyGray,
                      child: IconButton(
                        icon: Icon(
                          isMuted ? Icons.volume_mute : Icons.volume_up,
                          color: AppColors.white,
                        ),
                        onPressed: () => playerController.setVolume(isMuted ? 1 : 0),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: AppColors.dustyGray,
                      child: IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: AppColors.white,
                        ),
                        onPressed: () => _changePlaybackState(),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: AppColors.dustyGray,
                      child: IconButton(
                        icon: Icon(
                          Icons.loop_rounded,
                          color: isLooping ? AppColors.mineShaft : AppColors.white,
                        ),
                        onPressed: () => _changeLoopState(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container();
        }),
      ],
    );
  }

  _changePlaybackState() {
    if (widget.controller != null) {
      VideoPlayerController videoController = widget.controller!;
      videoController.value.isPlaying ? videoController.pause() : videoController.play();
    }
  }

  _changeLoopState() {
    if (widget.controller != null) {
      VideoPlayerController videoController = widget.controller!;
      videoController.value.isLooping ? videoController.setLooping(false) : videoController.setLooping(true);
    }
  }
}
