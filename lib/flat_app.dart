import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'common/redux/app/app_state.dart';
import 'common/navigation/navigation_key.dart';
import 'common/utils/styles/app_colors.dart';
import 'common/utils/styles/styles.dart';
import 'features/firebase/home/tabs/green_page.dart';
import 'features/firebase/home/tabs/red_page.dart';
import 'features/home/home_screen.dart';

class FlatApp extends StatelessWidget {
  const FlatApp(Key? key, this.store) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigatorKey.key,
        routes: {
          'red' : (_) => const RedPage(),
          'green' : (_) => const GreenPage(),
        },
        title: 'FlatAndFast',
        theme: theme.copyWith(
          scaffoldBackgroundColor: AppColors.bgScreen,
          appBarTheme: AppBarStyles.appBarTheme,
          colorScheme: theme.colorScheme.copyWith(
            primary: AppColors.primary,
          ),
          elevatedButtonTheme: ButtonStyles.elevatedButtonTheme,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
