import 'dart:math';

import 'package:flat_and_fast/common/controls/cards/tinder/back_card.dart';
import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';

import 'card_status.dart';
import 'stamp.dart';

const topPadding = 64.0;
const leftPadding = 50.0;
const superLikeText = 'SUPER\n LIKE';
const dislikeText = 'NOPE';
const likeText = 'LIKE';

class FrontCard extends StatefulWidget {
  const FrontCard({
    Key? key,
    required this.isDragging,
    required this.angle,
    required this.position,
    required this.imageUrl,
    required this.status,
    required this.startPosition,
    required this.updatePosition,
    required this.endPosition,
  }) : super(key: key);

  final Function(DragStartDetails) startPosition;
  final Function(DragUpdateDetails) updatePosition;
  final Function() endPosition;

  final bool isDragging;
  final double angle;
  final Offset position;
  final String imageUrl;
  final CardStatus? status;

  @override
  _FrontCardState createState() => _FrontCardState();
}

class _FrontCardState extends State<FrontCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final milliseconds = widget.isDragging ? 0 : 400;
          final center = constraints.smallest.center(Offset.zero);
          final angle = widget.angle * pi / 180;

          final rotateMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);

          return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: milliseconds),
            transform: rotateMatrix
              ..translate(
                widget.position.dx,
                widget.position.dy,
              ),
            child: Stack(
              children: [
                BackCard(imageUrl: widget.imageUrl),
                Builder(builder: (context) {
                  var statusOpacity = getStatusOpacity(widget.position);

                  if (widget.status == null) return Container();
                  switch (widget.status) {
                    case CardStatus.like:
                      return Positioned(
                          top: topPadding,
                          left: leftPadding,
                          child: Stamp(
                            angle: -0.5,
                            color: AppColors.green,
                            text: likeText,
                            opacity: statusOpacity,
                          ));
                    case CardStatus.dislike:
                      return Positioned(
                          top: topPadding,
                          right: leftPadding,
                          child: Stamp(
                            angle: 0.5,
                            color: AppColors.redAccent,
                            text: dislikeText,
                            opacity: statusOpacity,
                          ));
                    case CardStatus.superLike:
                      return Positioned(
                          bottom: topPadding * 2,
                          right: 0.0,
                          left: 0.0,
                          child: Stamp(
                            color: AppColors.blue,
                            text: superLikeText,
                            opacity: statusOpacity,
                          ));
                    default:
                      return Container();
                  }
                }),
              ],
            ),
          );
        },
      ),
      onPanStart: (details) => widget.startPosition(details),
      onPanUpdate: (details) => widget.updatePosition(details),
      onPanEnd: (details) => widget.endPosition(),
    );
  }

  double getStatusOpacity(Offset position) {
    const delta = 100;
    final pos = max(
      position.dx.abs(),
      position.dy.abs(),
    );
    final opacity = pos / delta;
    return min(opacity, 1);
  }
}
