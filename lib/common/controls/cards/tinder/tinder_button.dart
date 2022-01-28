import 'package:flat_and_fast/common/controls/containers/circle_container.dart';
import 'package:flutter/material.dart';

import 'card_status.dart';

class TinderButton extends StatefulWidget {
  const TinderButton({
    Key? key,
    required this.positiveColor,
    required this.negativeColor,
    required this.icon,
    required this.action,
    this.iconSize = 35.0,
    this.buttonSize = 60.0,
    this.buttonBorder = 1.0,
    this.elevation = 1.0,
    this.buttonStatus = CardStatus.like,
    this.actualStatus = CardStatus.like,
  }) : super(key: key);

  final CardStatus? buttonStatus;
  final CardStatus? actualStatus;
  final Color positiveColor;
  final Color negativeColor;
  final IconData icon;
  final Function action;
  final double iconSize;
  final double buttonSize;
  final double buttonBorder;
  final double elevation;

  @override
  State<StatefulWidget> createState() => _TinderButtonState();
}

class _TinderButtonState extends State<TinderButton> {
  @override
  Widget build(BuildContext context) {
    return CircleContainer(
      size: widget.buttonSize,
      borderWidth: widget.buttonBorder,
      borderColor: widget.positiveColor,
      backgroundColor: widget.actualStatus == widget.buttonStatus ? widget.positiveColor : widget.negativeColor,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Builder(builder: (context) {
          if (widget.elevation > 0) {
            return Material(
              shape: const CircleBorder(),
              elevation: widget.elevation,
              child: Icon(
                widget.icon,
                color: widget.actualStatus == widget.buttonStatus ? widget.negativeColor : widget.positiveColor,
                size: widget.iconSize,
              ),
            );
          }

          return Icon(
            widget.icon,
            color: widget.actualStatus == widget.buttonStatus ? widget.negativeColor : widget.positiveColor,
            size: widget.iconSize,
          );
        }),
        onPressed: () => widget.action(),
      ),
    );
  }
}
