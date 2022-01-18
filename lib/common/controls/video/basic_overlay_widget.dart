import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const playButtonSize = 50.0;

class BasicOverlayWidget extends StatefulWidget {
  final VideoPlayerController controller;

  const BasicOverlayWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _BasicOverlayWidgetState createState() => _BasicOverlayWidgetState();
}

class _BasicOverlayWidgetState extends State<BasicOverlayWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _changePlaybackState(),
      child: Stack(
        children: [
          widget.controller.value.isPlaying
              ? Container()
              : Container(
                  alignment: Alignment.center,
                  color: AppColors.darkBlur,
                  child: const Icon(
                    Icons.play_arrow,
                    color: AppColors.white,
                    size: playButtonSize,
                  ),
                ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: VideoProgressIndicator(
              widget.controller,
              allowScrubbing: true,
            ),
          )
        ],
      ),
    );
  }

  _changePlaybackState() {
    widget.controller.value.isPlaying ? widget.controller.pause() : widget.controller.play();
  }
}
