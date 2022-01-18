import 'package:flat_and_fast/common/controlls/carousel.dart';
import 'package:flutter/material.dart';

class CarouselScreen extends StatelessWidget {
  const CarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CarouselScreen'),
      ),
      body: const Carousel(),
    );
  }
}