import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'common/redux/app/app_state.dart';
import 'common/navigation/navigation_key.dart';
import 'common/utils/styles/themes.dart';
import 'features/firebase/home/tabs/green_page.dart';
import 'features/firebase/home/tabs/red_page.dart';
import 'features/home/home_screen.dart';

class FlatApp extends StatelessWidget {
  const FlatApp(Key? key, this.store) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: ThemeManagerWrapper(
        initialValue: ThemeMode.light,
        child: Builder(builder: (context) {
          ThemeManager? themeManager = ThemeManagerWrapper.of(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigatorKey.key,
            routes: {
              'red': (_) => const RedPage(),
              'green': (_) => const GreenPage(),
            },
            title: 'FlatAndFast',
            themeMode: themeManager?.theme,
            theme: MyThemes.light,
            darkTheme: MyThemes.dark,
            home: const HomeScreen(),
          );
        }),
      ),
    );
  }
}
