import 'package:flat_and_fast/common/net/network_client.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/common/utils/log.dart';
import 'package:redux/redux.dart';

import 'gradient_screen_actions.dart' as actions;

class GradientViewModel {
  GradientViewModel({
    required this.loadSomething,
    required this.isLoading,
  });

  final bool isLoading;

  final Function(NetworkClient, Log) loadSomething;

  static GradientViewModel fromStore(Store<AppState> store) {
    return GradientViewModel(
      isLoading: store.state.uiState.gradientState.isLoading,
      loadSomething: (client, log) => store.dispatch(
        actions.loadSomething(client, log),
      ),
    );
  }
}
