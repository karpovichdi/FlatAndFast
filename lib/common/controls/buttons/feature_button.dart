import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flutter/material.dart';

class FeatureButton extends StatelessWidget {
  const FeatureButton({
    Key? key,
    required this.action,
    required this.title,
    this.icon,
  }) : super(key: key);

  final Function() action;
  final String title;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Builder(
        builder: (context) {
          if(icon != null){
            return ElevatedButton.icon(
              icon: icon!,
              onPressed: action,
              label: Text(
                title,
                style: TextStyles.button1,
              ),
            );
          }
          return ElevatedButton(
            onPressed: action,
            child: Text(
              title,
              style: TextStyles.button1,
            ),
          );
        }
      ),
    );
  }
}
