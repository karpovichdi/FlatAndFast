import 'package:flat_and_fast/features/databases/sqlite/sqlite_screen.dart';
import 'package:flutter/material.dart';

import '../../common/controls/buttons/feature_button.dart';
import '../../common/navigation/navigation_helper.dart';
import '../../common/utils/styles/styles.dart';

const pageTitle = 'UI Templates';
const sqliteTitle = 'SQLite';

class DatabasesScreen extends StatelessWidget {
  const DatabasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              action: () => NavigationHelper.goToWidget(widget: const SQLiteScreen(), context: context),
              title: sqliteTitle,
            ),
          ],
        ),
      ),
    );
  }
}
