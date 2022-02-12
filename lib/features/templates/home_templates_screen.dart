import 'package:flat_and_fast/features/templates/profile/profile_screen.dart';
import 'package:flat_and_fast/features/templates/shop_catalog/shop_catalog_screen.dart';
import 'package:flat_and_fast/features/templates/talent_hire/talent_hire_screen.dart';
import 'package:flat_and_fast/features/templates/travel_diary/travel_diary_screen.dart';
import 'package:flutter/material.dart';

import '../../common/controls/buttons/feature_button.dart';
import '../../common/navigation/navigation_helper.dart';
import '../../common/utils/styles/styles.dart';
import '../../common/utils/styles/themes.dart';
import 'furniture/furniture_screen.dart';
import 'login/login_screen.dart';

const pageTitle = 'UI Templates';
const talentHireTitle = 'Talent hire';
const loginTitle = 'Login';
const profileTitle = 'Dynamic background';
const shopCatalogTitle = 'Catalog';
const travelDiaryTitle = 'Social web';
const furnitureTitle = 'Furniture';

class HomeTemplatesScreen extends StatelessWidget {
  const HomeTemplatesScreen({Key? key}) : super(key: key);

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
            FeatureButton(
              action: () => NavigationHelper.goToWidget(widget: const ProfileScreen(), context: context),
              title: profileTitle,
            ),
            FeatureButton(
              action: () => NavigationHelper.goToWidget(widget: const ShopCatalogScreen(), context: context),
              title: shopCatalogTitle,
            ),
            FeatureButton(
              action: () => NavigationHelper.goToWidget(widget: const TravelDiaryScreen(), context: context),
              title: travelDiaryTitle,
            ),
            FeatureButton(
              action: () => NavigationHelper.goToWidget(widget: const FurnitureScreen(), context: context),
              title: furnitureTitle,
            ),
          ],
        ),
      ),
    );
  }
}
