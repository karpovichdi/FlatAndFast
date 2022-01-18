import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'constrained_video_player.dart';

class FilePlayer extends StatefulWidget {
  const FilePlayer({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  _FilePlayerState createState() => _FilePlayerState();
}

class _FilePlayerState extends State<FilePlayer> {
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

    File? file = File(widget.path);
    controller = VideoPlayerController.file(file)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller?.play());

    _oldVideoPath = widget.path;
  }
}
