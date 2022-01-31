import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'firebase_home_actions.dart' as actions;

class FirebaseHomeViewModel {
  FirebaseHomeViewModel({
    required this.isLoading,
  });

  final bool isLoading;

  // final Function(Function) googleHome;

  static FirebaseHomeViewModel fromStore(Store<AppState> store) {
    return FirebaseHomeViewModel(
      isLoading: store.state.uiState.firebaseHomeState.isLoading,
      // goBack: (navigateBackAction) => store.dispatch(firebase.goBack(navigateBackAction)),
    );
  }
}
