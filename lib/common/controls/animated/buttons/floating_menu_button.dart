import 'package:flutter/material.dart';

import '../../../utils/helpers/math.dart';
import '../../../utils/styles/app_colors.dart';
import '../../buttons/circular_button.dart';

const bigButtonSize = 60.0;
const smallButtonSize = 50.0;

class FloatingMenuButton extends StatefulWidget {
  const FloatingMenuButton({
    Key? key,
    required this.firstButtonAction,
    required this.firstButtonIcon,
    required this.firstButtonColor,
    required this.secondButtonAction,
    required this.secondButtonIcon,
    required this.secondButtonColor,
  }) : super(key: key);

  final Function firstButtonAction;
  final Icon firstButtonIcon;
  final Color firstButtonColor;
  final Function secondButtonAction;
  final Icon secondButtonIcon;
  final Color secondButtonColor;

  @override
  _FloatingMenuButtonState createState() => _FloatingMenuButtonState();
}

class _FloatingMenuButtonState extends State<FloatingMenuButton> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _degOneTranslationAnimation, _degTwoTranslationAnimation, _degThreeTranslationAnimation;
  Animation? _rotationAnimation;

  @override
  void initState() {
    AnimationController animationController = _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    _degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    _degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem(tween: Tween(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    _rotationAnimation = Tween(begin: 180.0, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    AnimationController animationController = _animationController!;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        const IgnorePointer(
          child: SizedBox(
            height: 150.0,
            width: 150.0,
          ),
        ),
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(270.0), _degOneTranslationAnimation?.value * 100),
          child: Transform(
            transform: Matrix4.rotationZ(getRadiansFromDegree(_rotationAnimation?.value ?? 1))..scale(_degOneTranslationAnimation?.value ?? 1),
            alignment: Alignment.center,
            child: CircularButton(
              action: () {
                _animateButtonMenu(animationController);
              },
              color: AppColors.red,
              width: smallButtonSize,
              height: smallButtonSize,
              icon: const Icon(Icons.forward, color: AppColors.white),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(225.0), _degTwoTranslationAnimation?.value * 100),
          child: Transform(
            transform: Matrix4.rotationZ(getRadiansFromDegree(_rotationAnimation?.value ?? 1))..scale(_degTwoTranslationAnimation?.value ?? 1),
            alignment: Alignment.center,
            child: CircularButton(
              action: () {
                widget.secondButtonAction();
                _animateButtonMenu(animationController);
              },
              color: widget.secondButtonColor,
              width: smallButtonSize,
              height: smallButtonSize,
              icon: widget.secondButtonIcon,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(180.0), _degThreeTranslationAnimation?.value * 100),
          child: Transform(
            transform: Matrix4.rotationZ(getRadiansFromDegree(_rotationAnimation?.value ?? 1))..scale(_degThreeTranslationAnimation?.value ?? 1),
            alignment: Alignment.center,
            child: CircularButton(
              action: () {
                widget.firstButtonAction();
                _animateButtonMenu(animationController);
              },
              color: widget.firstButtonColor,
              width: smallButtonSize,
              height: smallButtonSize,
              icon: widget.firstButtonIcon,
            ),
          ),
        ),
        Transform(
          transform: Matrix4.rotationZ(getRadiansFromDegree(_rotationAnimation?.value ?? 1)),
          alignment: Alignment.center,
          child: CircularButton(
            action: () {
              _animateButtonMenu(animationController);
            },
            color: AppColors.froly,
            width: bigButtonSize,
            height: bigButtonSize,
            icon: const Icon(Icons.menu, color: AppColors.white),
          ),
        ),
      ],
    );
  }

  _animateButtonMenu(AnimationController animationController) {
    if (animationController.isCompleted) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }
}
