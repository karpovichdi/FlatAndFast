import 'package:flat_and_fast/common/controls/carousel.dart';
import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flutter/material.dart';

class CarouselScreen extends StatelessWidget {
  const CarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carousel',
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: const Carousel(),
    );
  }
}
