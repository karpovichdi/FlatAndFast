import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:firebase_core/firebase_core.dart';

import 'common/redux/app/app_reducer.dart';
import 'common/redux/app/app_state.dart';
import 'common/utils/storage/paths.dart';
import 'di.dart';
import 'flat_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      thunkMiddleware,
      LoggingMiddleware<AppState>.printer(),
    ],
  );

  await Firebase.initializeApp();

  runApp(FlatApp(null, store));
  _initialize();
}

Future _initialize() async {
  Paths.documentsDir = await getApplicationDocumentsDirectory();
}
