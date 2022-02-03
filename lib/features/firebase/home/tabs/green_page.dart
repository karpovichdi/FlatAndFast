import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';

class GreenPage extends StatelessWidget {
  const GreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.green,
      body: Center(
        child: Text('This is a green page'),
      ),
    );
  }
}
