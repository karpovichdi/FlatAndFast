import 'package:flat_and_fast/features/templates/shop_catalog/shop_catalog_screen.dart';
import 'package:flutter/material.dart';

class BurgerViewController extends StatefulWidget {
  const BurgerViewController({
    Key? key,
    required this.burgers,
  }) : super(key: key);

  final List<Burger> burgers;

  @override
  _BurgerViewControllerState createState() => _BurgerViewControllerState();
}

class _BurgerViewControllerState extends State<BurgerViewController> {
  final List<BurgerView>? _burgerViews = [];

  @override
  void initState() {
    _burgerViews?.addAll(widget.burgers.map((burger) => BurgerView(image: Image.asset(burger.imagePath), burger: burger)).toList());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _burgerViews?.forEach((burgerView) {
      precacheImage(burgerView.image.image, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
        physics: const ClampingScrollPhysics(),
        children: _burgerViews!);
  }
}

class BurgerView extends StatefulWidget {
  const BurgerView({
    Key? key,
    required this.image,
    required this.burger,
  }) : super(key: key);

  final Image image;
  final Burger burger;

  @override
  State<BurgerView> createState() => _BurgerViewState();
}

class _BurgerViewState extends State<BurgerView> {
  bool? _isFavorite;

  @override
  void initState() {
    _isFavorite = widget.burger.isFavourite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 240.0,
          decoration: BoxDecoration(image: DecorationImage(image: widget.image.image, fit: BoxFit.cover)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.favorite),
                  color: _isFavorite! ? Colors.pink : Colors.grey,
                  onPressed: () {
                    setState(() {
                      var isFavorite = _isFavorite as bool;
                      _isFavorite = !isFavorite;
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    Row(children: _getStars(widget.burger)),
                    const SizedBox(width: 2.0),
                    Text(
                      widget.burger.graduate.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4.0),
                    // SelectedPhoto(photoIndex: photoIndex, numberOfDots: photos.length)
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _getStars(Burger burger) {
    List<Widget> widgets = [];
    for (int i = 1; i < 6; i++) {
      widgets.add(
        Icon(
          Icons.star,
          color: i <= burger.graduate ? Colors.amber : Colors.grey,
        ),
      );
    }

    return widgets;
  }
}
