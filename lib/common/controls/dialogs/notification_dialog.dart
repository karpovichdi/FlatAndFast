import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({
    Key? key,
    required this.dismissAction,
    required this.title,
    required this.message,
    this.backgroundColor = AppColors.white70,
    this.buttonBackgroundColor = AppColors.froly,
    this.dialogWidth = 280.0,
    this.dialogHeight = 240.0,
    this.corners = 10.0,
    this.maxButtonHeight = 35.0,
    this.contentPaddings = const EdgeInsets.symmetric(
      vertical: 24.0,
      horizontal: 12.0,
    ),
  }) : super(key: key);
  final Function() dismissAction;
  final String title;
  final String message;
  final Color backgroundColor;
  final Color buttonBackgroundColor;
  final double dialogWidth;
  final double dialogHeight;
  final double corners;
  final double maxButtonHeight;
  final EdgeInsets contentPaddings;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissAction(),
      child: Container(
        color: backgroundColor,
        child: Center(
          child: SizedBox(
            height: dialogHeight,
            width: dialogWidth,
            child: GestureDetector(
              onTap: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(corners)),
                ),
                color: AppColors.athensGray,
                child: Padding(
                  padding: contentPaddings,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: TextStyles.headline3),
                      const Spacer(),
                      const Icon(
                        Icons.assignment_turned_in_sharp,
                        color: AppColors.green,
                        size: 100.0,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
