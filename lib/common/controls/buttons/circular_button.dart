import '../../utils/styles/app_colors.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key? key,
    this.width = 60.0,
    this.height = 60.0,
    this.color = AppColors.white,
    this.icon = const Icon(Icons.person_add, color: AppColors.white),
    required this.action,
  }) : super(key: key);

  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: () => action(),
      ),
    );
  }
}
