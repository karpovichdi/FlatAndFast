import 'package:flat_and_fast/common/controls/buttons/feature_button.dart';
import 'package:flat_and_fast/common/navigation/navigation_helper.dart';
import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flat_and_fast/features/camera/camera_screen.dart';
import 'package:flat_and_fast/features/controls/controls_screen.dart';
import 'package:flat_and_fast/features/databases/databases_screen.dart';
import 'package:flat_and_fast/features/firebase/login/firebase_login_screen.dart';
import 'package:flat_and_fast/features/templates/home_templates_screen.dart';
import 'package:flutter/material.dart';

import '../../common/utils/styles/themes.dart';
import '../../flat_app.dart';

const pageTitle = 'Flat and Fast';
const controlsTitle = 'Controls';
const carouselTitle = 'Carousel';
const photoVideoTitle = 'Photo / Video';
const firebaseTitle = 'Firebase';
const pageTemplatesTitle = 'Page templates';
const databasesTitle = 'Databases';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeManager? themeManager = ThemeManagerWrapper.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageTitle,
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ThemeMode newThemeMode = themeManager?.theme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
              themeManager?.setTheme(newThemeMode);
            },
            icon: themeManager?.theme == ThemeMode.dark ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.wb_sunny),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            FeatureButton(
              action: () => NavigationHelper.goToWidget(widget: const ControlsScreen(), context: context),
              title: controlsTitle,
            ),
            FeatureButton(
              action: () => NavigationHelper.goToWidget(widget: const CameraScreen(), context: context),
              title: photoVideoTitle,
            ),
            FeatureButton(
              action: () => NavigationHelper.goToWidget(widget: const FirebaseLoginScreen(), context: context),
              title: firebaseTitle,
            ),
            FeatureButton(
              action: () => NavigationHelper.goToWidget(widget: const HomeTemplatesScreen(), context: context),
              title: pageTemplatesTitle,
            ),
            FeatureButton(
              action: () => NavigationHelper.goToWidget(widget: const DatabasesScreen(), context: context),
              title: databasesTitle,
            ),
          ],
        ),
      ),
    );
  }
}
