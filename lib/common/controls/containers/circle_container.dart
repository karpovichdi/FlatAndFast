import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    Key? key,
    required this.size,
    required this.child,
    this.borderColor = Colors.white,
    this.borderOpacity = 1.0,
    this.borderWidth = 0.0,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final double size;
  final Color borderColor;
  final double borderOpacity;
  final double borderWidth;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: borderColor.withOpacity(borderOpacity),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          child: child,
        ),
      ),
    );
  }
}
