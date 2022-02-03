import 'package:flutter/material.dart';

import '../../../../common/utils/styles/app_colors.dart';

class RedPage extends StatelessWidget {
  const RedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.red,
      body: Center(
        child: Text('This is a red page'),
      ),
    );
  }
}
