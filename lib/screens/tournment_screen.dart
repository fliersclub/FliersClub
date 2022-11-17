import 'package:fliersclub/screens/fixture_screen.dart';
import 'package:fliersclub/screens/tournamentdetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TournamentScreen extends StatefulWidget {
  @override
  State<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  bool clubmatch1ended = false;
  bool clubmatch2ended = false;
  bool clubmatch3ended = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Text(
            'Tournaments',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Container(
          height: 100,
          width: double.infinity,
          child: Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Clubname vs clubname',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: clubmatch1ended == true
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return FixtureScreen();
                              }));
                            },
                            child: Text('View'))
                        : ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            onPressed: () async {
                              bool isMatchend = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TournamentDetailPage();
                              }));
                              print(isMatchend);
                              setState(() {
                                clubmatch1ended = isMatchend;
                              });
                            },
                            child: Text('start match')),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 100,
          width: double.infinity,
          child: Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Clubname vs clubname',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: clubmatch2ended == true
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return FixtureScreen();
                              }));
                            },
                            child: Text('View'))
                        : ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            onPressed: () async {
                              bool isMatchend = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TournamentDetailPage();
                              }));
                              print(isMatchend);
                              setState(() {
                                clubmatch2ended = isMatchend;
                              });
                            },
                            child: Text('start match')),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 100,
          width: double.infinity,
          child: Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Clubname vs clubname',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: clubmatch3ended == true
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return FixtureScreen();
                              }));
                            },
                            child: Text('View'))
                        : ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            onPressed: () async {
                              bool isMatchend = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TournamentDetailPage();
                              }));
                              print(isMatchend);
                              setState(() {
                                clubmatch3ended = isMatchend;
                              });
                            },
                            child: Text('start match')),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
