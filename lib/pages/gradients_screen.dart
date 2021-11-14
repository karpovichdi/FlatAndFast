import 'package:flat_and_fast/views/pokeball.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientScreen extends StatelessWidget{
  const GradientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GradientsScreen')),
      backgroundColor: Colors.amberAccent.shade200,
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0,8,0,8),
            child: Center(
              child: Text('LinearGradient',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.black
              ),),
            ),
          ),
          Center(
            child: Pokeball(
                backgroundColor: Colors.white,
                shadowColor: Colors.redAccent,
                gradientColors: [Colors.redAccent, Colors.orangeAccent],
                gradientStops: [0.12, 0.86]),
          )
        ]
      ),
    );
  }
}