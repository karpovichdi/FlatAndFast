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
    );
  }
}
