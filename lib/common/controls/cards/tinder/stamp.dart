import 'package:flutter/material.dart';

class Stamp extends StatelessWidget {
  const Stamp({
    Key? key,
    this.angle = 0,
    required this.color,
    required this.text,
    required this.opacity,
  }) : super(key: key);

  final double angle;
  final Color color;
  final String text;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: color, width: 4.0),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
