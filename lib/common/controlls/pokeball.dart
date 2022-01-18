import 'package:flat_and_fast/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Pokeball extends StatelessWidget {
  const Pokeball(
      {Key? key,
      required this.backgroundColor,
      required this.shadowColor,
      required this.gradientColors,
      required this.gradientStops})
      : super(key: key);

  final Color backgroundColor;
  final Color shadowColor;
  final List<Color> gradientColors;
  final List<double> gradientStops;

  @override
  Widget build(BuildContext context) {
    const pokeballSize = 306.0;
    const delimiterSize = 23.0;
    const backgroundCircleSize = 137.0;
    const foregroundCircleSize = 83.0;

    return SizedBox(
      width: pokeballSize,
      height: pokeballSize,
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                stops: gradientStops,
                colors: gradientColors,
                begin: Alignment(-1, 0),
                end: Alignment(1, 0),
              ).createShader(rect);
            },
            child: Container(
                width: pokeballSize,
                height: pokeballSize,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: backgroundColor)),
          ),
          Align(
            child: Container(color: backgroundColor, height: delimiterSize),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
                Assets.images.poketballBottomPart.path,
                alignment: Alignment.bottomCenter),
          ),
          Align(
              child: Container(
                  width: backgroundCircleSize,
                  height: backgroundCircleSize,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: backgroundColor))),
          Align(
              child: Container(
                  width: foregroundCircleSize,
                  height: foregroundCircleSize,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: shadowColor))),
        ],
      ),
    );
  }
}
