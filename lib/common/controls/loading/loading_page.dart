import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'cupertino_colored_loading_indicator.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
    this.color
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(
        builder: (context) {
          if (Platform.isIOS) {
            return CupertinoColoredLoadingIndicator(
              radius: 20,
              color: color ?? AppColors.froly,
            );
          }

          return CircularProgressIndicator(
            color: color ?? AppColors.froly,
          );
        },
      ),
    );
  }
}
