import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class LoadingMemoryImage extends StatefulWidget {
  const LoadingMemoryImage({
    Key? key,
    required this.path,
    required this.loadingWidget,
    required this.isBusy,
    this.imageSize,
  }) : super(key: key);

  final bool isBusy;
  final double? imageSize;
  final String path;
  final Widget loadingWidget;

  @override
  State createState() => _LoadingMemoryImageState();
}

class _LoadingMemoryImageState extends State<LoadingMemoryImage> {
  Image? _image;
  bool _error = false;
  bool _mounted = false;

  ImageStreamListener? _imageStreamListener;

  Uint8List? uint8listOld;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      Widget? image = widget.loadingWidget;
      const imageNotSetWidget = Center(child: Text('Image no set'));

      _updateImage();

      if (_error) {
        image = imageNotSetWidget;
      } else if (_mounted) {
        image = widget.isBusy ? widget.loadingWidget : _image;
      }

      return image ?? imageNotSetWidget;
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _removeListener();

    super.dispose();
  }

  void _updateImage() {
    var file = File(widget.path);
    if(!file.existsSync()){
      _error = true;
      return;
    }

    var uint8list = Uint8List.fromList(
      file.readAsBytesSync(),
    );

    if (widget.path.isEmpty || uint8list.length == uint8listOld?.length) {
      return;
    }

    uint8listOld = uint8list;
    _mounted = false;

    _removeListener();

    _image = Image.memory(
      uint8list,
      width: widget.imageSize,
      height: widget.imageSize,
      fit: BoxFit.cover,
    );

    final imageStreamListener = _imageStreamListener = ImageStreamListener((info, call) {
      Future.delayed(Duration.zero, () {
        setState(() {
          _error = false;
          _mounted = true;
        });
      });
    }, onError: (dynamic exception, StackTrace? stackTrace) {
      if (!_error) {
        setState(() {
          _error = true;
        });
      }
    });

    _image?.image.resolve(const ImageConfiguration()).addListener(imageStreamListener);
  }

  void _removeListener() {
    final imageStreamListener = _imageStreamListener;
    if (imageStreamListener != null) {
      _image?.image.resolve(const ImageConfiguration()).removeListener(imageStreamListener);
    }
  }
}
