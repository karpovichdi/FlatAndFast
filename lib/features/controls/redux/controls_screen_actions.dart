import 'package:flat_and_fast/common/net/network_client.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/common/utils/log.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class LoadingAction {}

class LoadingFinishedAction {}

ThunkAction<AppState> loadSomething(NetworkClient networkClient, Log log) {
  return (Store<AppState> store) async {
    store.dispatch(LoadingAction());
    await Future.delayed(const Duration(seconds: 3));
    store.dispatch(LoadingFinishedAction());
  };
}
