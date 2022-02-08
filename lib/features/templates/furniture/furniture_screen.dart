import 'package:flutter/material.dart';

import '../../../common/utils/helpers/colors.dart';

class FurnitureScreen extends StatefulWidget {
  const FurnitureScreen({Key? key}) : super(key: key);

  @override
  _FurnitureScreenState createState() => _FurnitureScreenState();
}

class _FurnitureScreenState extends State<FurnitureScreen> with SingleTickerProviderStateMixin {
  TabController? controller;

  List<MenuItem> headerMenu = [
    MenuItem(Icons.folder_shared, 'Favorites'),
    MenuItem(Icons.account_balance_wallet, 'Wallet'),
    MenuItem(Icons.print, 'Footprint'),
    MenuItem(Icons.computer, 'Coupon'),
  ];

  List<MenuPaymentItem> paymentMenu = [
    MenuPaymentItem('assets/images/card.png', 'Pending payment', 5),
    MenuPaymentItem('assets/images/box.png', 'To be snipped', 2),
    MenuPaymentItem('assets/images/trucks.png', 'To be received', 8),
    MenuPaymentItem('assets/images/returnbox.png', 'Return / Replace', 0),
  ];

  List<MenuItem> mainMenu = [
    MenuItem(Icons.account_box, 'Gift card', color: Colors.red),
    MenuItem(Icons.credit_card, 'Bank card', color: Color(getColorHexFromStr('#E89300'))),
    MenuItem(Icons.grid_on, 'Replacement code', color: Color(getColorHexFromStr('#FB8662'))),
    MenuItem(Icons.pages, 'Consulting collection', color: Colors.blue),
    MenuItem(Icons.person, 'Customer service', color: Color(getColorHexFromStr('#ECB800'))),
  ];

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(children: [
          Stack(children: [
            Container(
              height: 250.0,
              width: double.infinity,
              color: Colors.redAccent,
            ),
            Positioned(
              bottom: 250.0,
              right: 100.0,
              child: Container(
                height: 400.0,
                width: 400.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200.0),
                  color: Color(getColorHexFromStr('#FEE16D')).withOpacity(0.4),
                ),
              ),
            ),
            Positioned(
              bottom: 300.0,
              left: 150.0,
              child: Container(
                height: 300.0,
                width: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150.0),
                  color: Color(getColorHexFromStr('#FEE16D')).withOpacity(0.5),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 15.0),
                        Container(
                          alignment: Alignment.topLeft,
                          height: 75.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(37.5),
                            border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 3.0),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/chris.jpg'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pino',
                              style: TextStyle(fontFamily: 'Quicksand', fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '176****590',
                              style: TextStyle(fontFamily: 'Quicksand', fontSize: 15.0, color: Colors.black.withOpacity(0.7)),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15.0),
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {},
                        color: Colors.white,
                        iconSize: 30.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 75.0,
                  child: Builder(builder: (context) {
                    const double runSpacing = 4;
                    const double spacing = 4;
                    const columns = 4;
                    final itemSize = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) / columns;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        runSpacing: runSpacing,
                        spacing: spacing,
                        alignment: WrapAlignment.center,
                        children: List.generate(headerMenu.length, (index) {
                          return SizedBox(
                            width: itemSize,
                            child: Column(
                              children: [
                                IconButton(
                                  icon: Icon(headerMenu[index].icon),
                                  color: Colors.white,
                                  iconSize: 40.0,
                                  onPressed: () {},
                                ),
                                Text(
                                  headerMenu[index].title,
                                  style: const TextStyle(fontFamily: 'Quicksand', fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: 250.0,
                    child: GridView.builder(
                        itemCount: paymentMenu.length,
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (BuildContext ctx, index) {
                          return Card(
                            elevation: 4.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    paymentMenu[index].imagePath,
                                    fit: BoxFit.cover,
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                  Text(
                                    paymentMenu[index].title,
                                    style: const TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    paymentMenu[index].count.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 15.0,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ]),
          Column(
            children: List.generate(
              mainMenu.length,
              (index) => listItem(mainMenu[index].title, mainMenu[index].color!, mainMenu[index].icon),
            ),
          ),
        ]),
      ]),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: controller,
          indicatorColor: Colors.yellow,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.event_seat, color: Colors.grey)),
            Tab(icon: Icon(Icons.timer, color: Colors.grey)),
            Tab(icon: Icon(Icons.shopping_cart, color: Colors.grey)),
            Tab(icon: Icon(Icons.person_outline, color: Colors.yellow))
          ],
        ),
      ),
    );
  }

  Widget listItem(String title, Color buttonColor, iconButton) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: buttonColor.withOpacity(0.3)),
            child: Icon(iconButton, color: buttonColor, size: 25.0),
          ),
          const SizedBox(width: 25.0),
          SizedBox(
            width: MediaQuery.of(context).size.width - 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(fontFamily: 'Quicksand', fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20.0)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String title;
  final Color? color;

  MenuItem(this.icon, this.title, {this.color});
}

class MenuPaymentItem {
  final String imagePath;
  final String title;
  final int count;

  MenuPaymentItem(this.imagePath, this.title, this.count);
}
