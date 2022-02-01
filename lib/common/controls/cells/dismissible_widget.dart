import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';

class DismissibleWidget<T> extends StatelessWidget {
  const DismissibleWidget({
    Key? key,
    required this.child,
    required this.item,
    required this.onDismissed,
  }) : super(key: key);

  final Widget child;
  final DismissDirectionCallback onDismissed;
  final T item;

  @override
  Widget build(BuildContext context) => Dismissible(
        direction: DismissDirection.startToEnd,
        onDismissed: onDismissed,
        key: ObjectKey(item),
        child: child,
        background: Container(
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: const Icon(
            Icons.delete_forever,
            color: AppColors.white,
            size: 30.0,
          ),
        ),
      );
}
