import 'dart:async';

import 'package:flat_and_fast/pages/carousels_screen.dart';
import 'package:flat_and_fast/pages/gradients_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainMenuPage(),
    );
  }
}

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: ElevatedButton(
                  onPressed: () {
                    gradientsButtonClicked(context: context);
                  },
                  child: const Text('Gradients')),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: ElevatedButton(
                  onPressed: () {
                    carouselsButtonClicked(context: context);
                  },
                  child: const Text('Carousels')),
            ),
          ],
        ),
      ),
    );
  }

  gradientsButtonClicked({required BuildContext context}) {
    _navigateToWidget(widget: const GradientScreen(), context: context);
  }

  carouselsButtonClicked({required BuildContext context}) {
    _navigateToWidget(widget: const CarouselScreen(), context: context);
  }

  Future _navigateToWidget(
      {required Widget widget, required BuildContext context}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}
