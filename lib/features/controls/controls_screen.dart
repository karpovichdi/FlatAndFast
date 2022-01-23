import 'dart:math';

import 'package:flat_and_fast/common/controls/buttons/feature_button.dart';
import 'package:flat_and_fast/common/controls/cards/tinder/tinder_screen.dart';
import 'package:flat_and_fast/common/controls/carousels/carousel_screen.dart';
import 'package:flat_and_fast/common/controls/labels/arc_text.dart';
import 'package:flat_and_fast/common/controls/pokeball.dart';
import 'package:flat_and_fast/common/navigation/navigation_helper.dart';
import 'package:flat_and_fast/common/net/network_client.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/common/utils/log.dart';
import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flat_and_fast/features/controls/redux/controls_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../di.dart';

const arcTextRadius = 100.0;
const arcTextStartPoint = -pi / 2;
const arcTextControlSize = 300.0;
const pageTitle = 'Controls';
const arcText = 'ArcText. Circular text should be here. Circular text should be here.';
const linearGradientTitle = 'LinearGradient';

const pageTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w300,
  color: AppColors.black,
);

class ControlsScreen extends StatelessWidget {
  const ControlsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ControlsViewModel>(
        onInitialBuild: _initializeViewModel,
        converter: (store) {
          return ControlsViewModel.fromStore(store);
        },
        builder: (_, viewModel) {
          return Scaffold(
            appBar: AppBar(
                title: const Text(
              pageTitle,
              style: TextStyles.appBarTitle,
            )),
            body: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 32.0, top: 8.0),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Center(
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                          child: Center(
                            child: Text(
                              linearGradientTitle,
                              style: pageTextStyle,
                            ),
                          ),
                        ),
                        Pokeball(
                          backgroundColor: AppColors.white,
                          shadowColor: AppColors.redAccent,
                          gradientColors: [
                            AppColors.redAccent,
                            AppColors.orangeAccent,
                          ],
                          gradientStops: [0.12, 0.86],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  width: arcTextControlSize,
                  height: arcTextControlSize,
                  child: const ArcText(
                    radius: arcTextRadius,
                    text: arcText,
                    textStyle: pageTextStyle,
                    startAngle: arcTextStartPoint,
                  ),
                ),
                FeatureButton(
                  action: () => NavigationHelper.goToWidget(widget: const TinderScreen(), context: context),
                  title: 'Tinder',
                ),
                FeatureButton(
                  action: () => NavigationHelper.goToWidget(widget: const CarouselScreen(), context: context),
                  title: 'Carousel',
                ),
              ],
            ),
          );
        });
  }

  void _initializeViewModel(ControlsViewModel viewModel) {
    viewModel.loadSomething(getIt.get<NetworkClient>(), getIt.get<Log>());
  }
}
