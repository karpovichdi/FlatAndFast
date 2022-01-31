import 'package:flat_and_fast/features/firebase/home/redux/firebase_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../common/redux/app/app_state.dart';

class FirebaseHomeScreen extends StatelessWidget {
  const FirebaseHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FirebaseHomeViewModel>(converter: (store) {
      return FirebaseHomeViewModel.fromStore(store);
    }, builder: (_, viewModel) {
      return Container();
    });
  }
}
