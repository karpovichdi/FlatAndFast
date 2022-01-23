import 'package:flutter/material.dart';

class BackCard extends StatelessWidget {
  const BackCard({Key? key, required this.imageUrl,}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                imageUrl,
              ),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
