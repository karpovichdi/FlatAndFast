import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class MyThemes {
  static final dark = ThemeData(
    scaffoldBackgroundColor: AppColors.darkPurple,
    appBarTheme: AppBarStyles.darkAppBarTheme,
    iconTheme: const IconThemeData(color: AppColors.darkAppBar),
    colorScheme: baseThemeDark.colorScheme.copyWith(primary: AppColors.primaryDark),
    elevatedButtonTheme: ButtonStyles.elevatedButtonDarkTheme,
  );

  static final light = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarStyles.lightAppBarTheme,
    iconTheme: const IconThemeData(color: AppColors.darkPurple),
    colorScheme: baseThemeLight.colorScheme.copyWith(primary: AppColors.primaryLight),
    elevatedButtonTheme: ButtonStyles.elevatedButtonLightTheme,
  );

  static final baseThemeDark = ThemeData(colorScheme: const ColorScheme.dark());

  static final baseThemeLight = ThemeData(colorScheme: const ColorScheme.light());
}

class ThemeManagerWrapper extends StatefulWidget {
  final Widget child;
  final ThemeMode initialValue;

  const ThemeManagerWrapper({
    Key? key,
    required this.child,
    required this.initialValue,
  }) : super(key: key);

  static ThemeManager? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeManager>();
  }

  @override
  _ThemeManagerWrapperState createState() => _ThemeManagerWrapperState();
}

class _ThemeManagerWrapperState extends State<ThemeManagerWrapper> {
  ThemeMode? _theme;

  @override
  void initState() {
    _theme = widget.initialValue;
    super.initState();
  }

  void setTheme(ThemeMode theme) => setState(() {
    _theme = theme;
  });

  @override
  Widget build(BuildContext context) {
    return ThemeManager(child: widget.child, theme: _theme!, setTheme: (theme) => setTheme(theme));
  }
}

class ThemeManager extends InheritedWidget {
  final Widget child;
  final Function(ThemeMode) setTheme;
  final ThemeMode theme;

  const ThemeManager({
    Key? key,
    required this.child,
    required this.theme,
    required this.setTheme,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(ThemeManager oldWidget) {
    return theme != oldWidget.theme;
  }
}
