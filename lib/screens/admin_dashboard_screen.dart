import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fliersclub/screens/landing_screen.dart';
import 'package:fliersclub/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          Container(
              color: Colors.black,
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Super Admin',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          ListTile(
            title:
                Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Divider(),
          ListTile(
            title: Text('ClubUser Management',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Divider(),
        ],
      )),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LandingScreen()),
                    (Route<dynamic> route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
        title: Text('Dashboard'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Container(
                width: double.infinity,
                color: Colors.white12,
                height: 400,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    DashboardCard(title: 'No.of.clubs registered', count: '10'),
                    DashboardCard(
                        title: 'No.of.Tournaments registered', count: '5'),
                    DashboardCard(title: 'No.of users registered', count: '8'),
                    DashboardCard(title: 'No.of.clubs registered', count: '13'),
                  ],
                ),
              ),
            )
          ]),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Upcoming Tournaments',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: CarouselSlider(
              items: [
                Container(
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Club name vs Club name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text('venue : '),
                        SizedBox(
                          height: 4,
                        ),
                        Text('Date : '),
                        SizedBox(
                          height: 4,
                        ),
                        Text('Starting Time : '),
                        SizedBox(
                          height: 4,
                        ),
                      ]),
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
              options: CarouselOptions(
                viewportFraction: 0.8,
                enableInfiniteScroll: true,
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Ongoing Tournaments',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
          ),
          Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Club name vs Club name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Duration of Club name :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
              )),
          Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Club name vs Club name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Duration of Club name :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
              )),
        ],
      ),
    );
  }
}
