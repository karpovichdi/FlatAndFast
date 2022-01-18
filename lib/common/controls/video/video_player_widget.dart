import 'package:flat_and_fast/common/controls/loading/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'basic_overlay_widget.dart';

const loadingWidgetSize = 200.0;

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoPlayerController controller;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.controller.value.isInitialized
        ? Container(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: VideoPlayer(widget.controller),
                ),
                Positioned.fill(
                  child: BasicOverlayWidget(controller: widget.controller),
                ),
              ],
            ))
        : const SizedBox(
            height: loadingWidgetSize,
            child: Center(
              child: LoadingPage(),
            ),
          );
  }
}
