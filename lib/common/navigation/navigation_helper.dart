import 'package:flutter/material.dart';

abstract class NavigationHelper {
  static Future goToWidget({required Widget widget, required BuildContext context}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static Future goBack({required BuildContext context}) async {
    Navigator.pop(context);
  }
}