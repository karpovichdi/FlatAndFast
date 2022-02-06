import 'package:flat_and_fast/features/templates/talent_hire/talent_hire_screen.dart';
import 'package:flutter/material.dart';

import '../../common/controls/buttons/feature_button.dart';
import '../../common/navigation/navigation_helper.dart';
import '../../common/utils/styles/styles.dart';
import 'login/login_screen.dart';

const pageTitle = 'UI Templates';
const talentHireTitle = 'Talent hire';
const loginTitle = 'Login';

class HomeTemplatesScreen extends StatelessWidget {
  const HomeTemplatesScreen({Key? key}) : super(key: key);

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
              action: () => NavigationHelper.goToWidget(widget: const TalentHireScreen(), context: context),
              title: talentHireTitle,
            ),
            FeatureButton(
              action: () => NavigationHelper.goToWidget(widget: const LoginScreen(), context: context),
              title: loginTitle,
            ),
          ],
        ),
      ),
    );
  }
}
