import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TravelDiaryScreen extends StatefulWidget {
  const TravelDiaryScreen({Key? key}) : super(key: key);

  @override
  _TravelDiaryScreenState createState() => _TravelDiaryScreenState();
}

class _TravelDiaryScreenState extends State<TravelDiaryScreen> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.home, color: Colors.black)),
            Tab(icon: Icon(Icons.search, color: Colors.grey)),
            Tab(icon: Icon(Icons.graphic_eq, color: Colors.grey)),
            Tab(icon: Icon(Icons.add_circle_outline, color: Colors.grey)),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Not instagram',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.grey.shade900),
                ),
                const SizedBox(width: 90.0),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  color: Colors.grey.shade500,
                  iconSize: 30.0,
                  onPressed: () {},
                ),
                const SizedBox(width: 10.0),
                InkWell(
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/chris.jpg'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
            child: Container(
              padding: const EdgeInsets.only(left: 10.0),
              height: 100.0,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.grey.shade100),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.navigation, color: Colors.blue),
                    iconSize: 50.0,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'MALDIVES TRIP 2018',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 14.0),
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          'Add an update',
                          style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 16.0),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 50.0),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    iconSize: 30.0,
                    onPressed: () {
                      print('');
                    },
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  'FROM THE COMMUNITY',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontFamily: 'Montserrat'),
                ),
                Text(
                  'View All',
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15.0, fontFamily: 'Montserrat'),
                )
              ],
            ),
          ),
          _buildImageGrid(),
          _imgGalleryDetail(),
          _buildImageGrid(),
          _imgGalleryDetail(),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _imgGalleryDetail() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Maui Summer 2018',
                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 15.0),
              ),
              const SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Text(
                    'Teresa Soto added 52 Photos',
                    style: TextStyle(color: Colors.grey.shade700, fontFamily: 'Montserrat', fontSize: 11.0),
                  ),
                  const SizedBox(width: 4.0),
                  const Icon(
                    Icons.timer,
                    size: 4.0,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '2h ago',
                    style: TextStyle(color: Colors.grey.shade500, fontFamily: 'Montserrat', fontSize: 11.0),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.heart,
                    size: 20.0,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.messenger_outline, size: 20.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 15.0, right: 15.0),
      child: SizedBox(
        height: 225.0,
        child: Row(
          children: <Widget>[
            Container(
              height: 225.0,
              width: MediaQuery.of(context).size.width / 2 + 40.0,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0)),
                  image: DecorationImage(image: AssetImage('assets/images/beach1.jpg'), fit: BoxFit.cover)),
            ),
            const SizedBox(width: 2.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 111.5,
                  width: MediaQuery.of(context).size.width / 2 - 72.0,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                      ),
                      image: DecorationImage(image: AssetImage('assets/images/beach2.jpg'), fit: BoxFit.cover)),
                ),
                const SizedBox(height: 2.0),
                Container(
                  height: 111.5,
                  width: MediaQuery.of(context).size.width / 2 - 72.0,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15.0)),
                      image: DecorationImage(image: AssetImage('assets/images/beach3.jpg'), fit: BoxFit.cover)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
