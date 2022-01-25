import 'package:flat_and_fast/common/controls/buttons/feature_button.dart';
import 'package:flat_and_fast/common/navigation/navigation_helper.dart';
import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flat_and_fast/features/camera/camera_screen.dart';
import 'package:flat_and_fast/features/controls/controls_screen.dart';
import 'package:flat_and_fast/features/firebase/login/firebase_login_screen.dart';
import 'package:flutter/material.dart';

const pageTitle = 'Flat and Fast';
const controlsTitle = 'Controls';
const carouselTitle = 'Carousel';
const photoVideoTitle = 'Photo / Video';
const firebaseTitle = 'Firebase';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          pageTitle,
          style: TextStyles.appBarTitle,
        ),
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
          ],
        ),
      ),
    );
  }
}
