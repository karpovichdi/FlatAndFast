import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/styles/themes.dart';
import 'burger_view.dart';

class ShopCatalogScreen extends StatefulWidget {
  const ShopCatalogScreen({Key? key}) : super(key: key);

  @override
  State<ShopCatalogScreen> createState() => _ShopCatalogScreenState();
}

class _ShopCatalogScreenState extends State<ShopCatalogScreen> {
  final List<Burger> _burgers = [
    Burger(imagePath: 'assets/images/burger1-min3.png', graduate: 4, isFavourite: true),
    Burger(imagePath: 'assets/images/burger2-min3.png', graduate: 3, isFavourite: false),
    Burger(imagePath: 'assets/images/burger3-min3.png', graduate: 1, isFavourite: false),
    Burger(imagePath: 'assets/images/burger4-min3.png', graduate: 5, isFavourite: true),
    Burger(imagePath: 'assets/images/burger1-min3.png', graduate: 4, isFavourite: true),
    Burger(imagePath: 'assets/images/burger2-min3.png', graduate: 3, isFavourite: false),
    Burger(imagePath: 'assets/images/burger3-min3.png', graduate: 1, isFavourite: false),
    Burger(imagePath: 'assets/images/burger4-min3.png', graduate: 5, isFavourite: true),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeManager? themeManager = ThemeManagerWrapper.of(context);

    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: false,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            expandedHeight: 225.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Title',
                style: TextStyle(
                  color: themeManager?.theme == ThemeMode.dark ? AppColors.primaryDark : AppColors.darkPurple,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: BurgerViewController(burgers: _burgers),
            ),
          ),
          const CupertinoSliverRefreshControl(),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15.0),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'OPEN NOW UNTIL 7PM',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      const Text(
                        'The Cinnamon Snail',
                        style: TextStyle(
                          fontSize: 27.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: const <Widget>[
                          Text(
                            '17th st & Union Sq East',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Icon(Icons.location_on),
                          SizedBox(width: 5.0),
                          Text(
                            '400ft Away',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 7.0),
                      Row(
                        children: const <Widget>[
                          Icon(Icons.wifi, color: Colors.green),
                          SizedBox(width: 4.0),
                          Text(
                            'Location confirmed by 3 users today',
                            style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: const <Widget>[
                      Text(
                        'FEATURED ITEMS',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    const SizedBox(height: 10.0),
                    _buildListItem(_burgers[index].imagePath),
                  ],
                );
              },
              childCount: _burgers.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String picture) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(picture), fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              height: 100.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Maple Mustard Tempeh',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Marinated kale, onion, tomato and roasted',
                    style: TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'Montserrat',
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  Text(
                    'garlic aioli on grilled spelt bread',
                    style: TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'Montserrat',
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '\$11.25',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class Burger {
  final String imagePath;
  final int graduate;
  final bool isFavourite;

  Burger({
    required this.imagePath,
    required this.graduate,
    required this.isFavourite,
  });
}
