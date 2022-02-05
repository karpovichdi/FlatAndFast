import 'package:flutter/material.dart';

class TalentHireScreen extends StatefulWidget {
  const TalentHireScreen({Key? key}) : super(key: key);

  @override
  State<TalentHireScreen> createState() => _TalentHireScreenState();
}

class _TalentHireScreenState extends State<TalentHireScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FlutterLogo(size: 25.0),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back), color: Colors.grey),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            color: Colors.grey,
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                alignment: const Alignment(0.0, -0.40),
                height: 100.0,
                color: Colors.white,
                child: const Text(
                  'Get coaching',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25.0, 90.0, 25.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(blurRadius: 2.0, color: Colors.grey),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(25.0, 25.0, 5.0, 5.0),
                          child: const Text(
                            'YOU HAVE',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(25.0, 40.0, 5.0, 25.0),
                          child: const Text(
                            '206',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    // const SizedBox(width: 100.0),
                    const Spacer(),
                    Container(
                      height: 60.0,
                      width: 125.0,
                      margin: const EdgeInsets.only(right: 25.0),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent[100]?.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Center(
                        child: Text(
                          'Buy more',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 40.0),
          Container(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'MY COACHES',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    'VIEW PAST SESSIONS',
                    style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  )
                ],
              )),
          const SizedBox(height: 10.0),
          GridView.count(
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 4.0,
            shrinkWrap: true,
            children: <Widget>[
              _buildCard('Tom', 'Available', 1),
              _buildCard('Tom', 'Away', 2),
              _buildCard('Tom', 'Away', 3),
              _buildCard('Tom', 'Available', 4),
              _buildCard('Tom', 'Away', 5),
              _buildCard('Tom', 'Available', 6),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCard(String name, String status, int cardIndex) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 7.0,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 12.0),
          Stack(children: <Widget>[
            Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.green,
                image: const DecorationImage(
                  image: NetworkImage('https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40.0),
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: status == 'Away' ? Colors.amber : Colors.green,
                border: Border.all(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 2.0,
                ),
              ),
            )
          ]),
          const SizedBox(height: 8.0),
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            status,
            style: const TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: status == 'Away' ? Colors.grey : Colors.green,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: const Center(
                child: Text(
                  'Request',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      margin: cardIndex.isEven ? const EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0) : const EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0),
    );
  }
}
