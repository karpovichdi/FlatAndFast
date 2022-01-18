import 'package:flat_and_fast/common/controls/loading/loading_page.dart';
import 'package:flat_and_fast/common/controls/pokeball.dart';
import 'package:flat_and_fast/common/net/network_client.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/common/utils/log.dart';
import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flat_and_fast/features/gradients/redux/gradient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../di.dart';

class GradientScreen extends StatelessWidget {
  const GradientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GradientViewModel>(
        onInitialBuild: _initializeViewModel,
        converter: (store) {
          return GradientViewModel.fromStore(store);
        },
        builder: (_, viewModel) {
          return Scaffold(
            appBar: AppBar(
                title: const Text(
              'GradientsScreen',
              style: TextStyles.appBarTitle,
            )),
            backgroundColor: Colors.amberAccent.shade200,
            body: ListView(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                  child: Center(
                    child: Text(
                      'LinearGradient',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Pokeball(
                    backgroundColor: AppColors.white,
                    shadowColor: AppColors.redAccent,
                    gradientColors: [
                      AppColors.redAccent,
                      AppColors.orangeAccent,
                    ],
                    gradientStops: [0.12, 0.86],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _initializeViewModel(GradientViewModel viewModel) {
    viewModel.loadSomething(getIt.get<NetworkClient>(), getIt.get<Log>());
  }
}
