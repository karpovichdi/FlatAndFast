import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/styles/app_colors.dart';

class ImageCardDialog extends StatelessWidget {
  const ImageCardDialog({
    Key? key,
    required this.dismissAction,
    required this.imageFile,
    this.backgroundColor = AppColors.white70,
  }) : super(key: key);

  final Function() dismissAction;
  final Color backgroundColor;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    if (imageFile == null) {
      return Container();
    }
    return GestureDetector(
      onTap: () => dismissAction(),
      child: Container(
        color: backgroundColor,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Image.file(
              imageFile!,
            ),
          ),
        ),
      ),
    );
  }
}
