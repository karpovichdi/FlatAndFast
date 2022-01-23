import 'package:flat_and_fast/common/controls/containers/circle_container.dart';
import 'package:flutter/material.dart';

import 'card_status.dart';

const buttonSize = 60.0;
const iconSize = 35.0;
const buttonBorder = 1.0;

class TinderButton extends StatefulWidget {
  const TinderButton({
    Key? key,
    required this.buttonStatus,
    required this.actualStatus,
    required this.positiveColor,
    required this.negativeColor,
    required this.icon,
    required this.action,
  }) : super(key: key);

  final CardStatus? buttonStatus;
  final CardStatus? actualStatus;
  final Color positiveColor;
  final Color negativeColor;
  final IconData icon;
  final Function action;

  @override
  State<StatefulWidget> createState() => _TinderButtonState();
}

class _TinderButtonState extends State<TinderButton> {
  @override
  Widget build(BuildContext context) {
    return CircleContainer(
      size: buttonSize,
      borderWidth: buttonBorder,
      borderColor: widget.positiveColor,
      backgroundColor: widget.actualStatus == widget.buttonStatus ? widget.positiveColor : widget.negativeColor,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          widget.icon,
          color: widget.actualStatus == widget.buttonStatus ? widget.negativeColor : widget.positiveColor,
          size: iconSize,
        ),
        onPressed: () => widget.action(),
      ),
    );
  }
}
