import 'package:flutter/material.dart';

class LoadingNetworkImage extends StatefulWidget {
  const LoadingNetworkImage({
    Key? key,
    required this.imageUrl,
    required this.loadingWidget,
    required this.isBusy,
    this.imageSize,
  }) : super(key: key);

  final bool isBusy;
  final double? imageSize;
  final String imageUrl;
  final Widget loadingWidget;

  @override
  State createState() => _LoadingNetworkImageState();
}

class _LoadingNetworkImageState extends State<LoadingNetworkImage> {
  Image? _image;
  bool _error = false;
  bool _mounted = false;
  String? _oldImageUrl = '';

  ImageStreamListener? _imageStreamListener;

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
    if (_oldImageUrl == widget.imageUrl || widget.imageUrl.isEmpty) {
      return;
    }

    _oldImageUrl = widget.imageUrl;
    _mounted = false;

    _removeListener();

    _image = Image.network(
      widget.imageUrl,
      fit: BoxFit.cover,
      height: widget.imageSize,
      width: widget.imageSize,
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
