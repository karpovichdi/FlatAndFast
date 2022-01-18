import 'package:flat_and_fast/common/controls/video/constrained_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AssetPlayer extends StatefulWidget {
  const AssetPlayer({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  _AssetPlayerState createState() => _AssetPlayerState();
}

class _AssetPlayerState extends State<AssetPlayer> {
  VideoPlayerController? controller;

  String? _oldVideoPath;

  @override
  void initState() {
    super.initState();

    _initializeNewVideo();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.path != _oldVideoPath) {
      _initializeNewVideo();
    }

    return ConstrainedVideoPlayer(controller: controller);
  }

  void _initializeNewVideo() {
    controller?.dispose();

    controller = VideoPlayerController.asset(widget.path)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller?.play());

    _oldVideoPath = widget.path;
  }
}
