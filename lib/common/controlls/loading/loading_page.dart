import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'cupertino_colored_loading_indicator.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.white,
        child: Builder(
          builder: (context) {
            if (Platform.isIOS) {
              return const CupertinoColoredLoadingIndicator(
                radius: 20,
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
