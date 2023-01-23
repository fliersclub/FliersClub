import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fliersclub/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white12,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    StreamBuilder(
                      stream: _firestore.collection('ClubAdmin').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DashboardCard(
                              title: 'No.of.clubs ',
                              count: snapshot.data!.docs.length.toString());
                        }
                        return DashboardCard(title: 'No.of.clubs ', count: '0');
                      },
                    ),
                    StreamBuilder(
                      stream: _firestore.collection('Tournaments').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DashboardCard(
                              title: 'No.of.Tournaments ',
                              count: snapshot.data!.docs.length.toString());
                        }
                        return DashboardCard(
                            title: 'No.of.Tournments ', count: '0');
                      },
                    ),
                    StreamBuilder(
                      stream: _firestore.collection('Users').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DashboardCard(
                              title: 'No.of.users ',
                              count: snapshot.data!.docs.length.toString());
                        }
                        return DashboardCard(title: 'No.of.users ', count: '0');
                      },
                    ),
                    StreamBuilder(
                      stream: _firestore.collection('Referee').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DashboardCard(
                              title: 'No.of.referees ',
                              count: snapshot.data!.docs.length.toString());
                        }
                        return DashboardCard(
                            title: 'No.of.referees ', count: '0');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
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
                      children: []),
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
                      SizedBox(
                        height: 5,
                      ),
                    ]),
              )),
          Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, children: []),
              )),
        ],
      ),
    );
  }
}
