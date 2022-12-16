import 'package:fliersclub/screens/addmatch_screen.dart';
import 'package:fliersclub/screens/fixture_screen.dart';
import 'package:fliersclub/screens/timer_screen.dart';
import 'package:fliersclub/screens/tournamentdetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TournamentScreen2 extends StatefulWidget {
  @override
  State<TournamentScreen2> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen2> {
  bool clubmatch1ended = false;
  bool clubmatch2ended = false;
  bool clubmatch3ended = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AddMatchScreen();
            }));
          },
          child: Icon(Icons.add)),
      appBar: AppBar(
        title: Text('Tournament name'),
        backgroundColor: Colors.black,
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Text(
            'Tournament Name',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Container(
          width: double.infinity,
          child: Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Match 1'),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Participant 1',
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
                                return ScoreScreen();
                              }));
                            },
                            child: Text('View'))
                        : ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            onPressed: () async {
                              bool isMatchend = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TimerScreen();
                              }));
                              print(isMatchend);
                              setState(() {
                                clubmatch1ended = isMatchend;
                              });
                            },
                            child: Text('Enter Match')),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Match 2'),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Participant 2',
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
                                return ScoreScreen();
                              }));
                            },
                            child: Text('View'))
                        : ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            onPressed: () async {
                              bool isMatchend = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TimerScreen();
                              }));
                              print(isMatchend);
                              setState(() {
                                clubmatch2ended = isMatchend;
                              });
                            },
                            child: Text('Enter Match')),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Match 3'),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Participant 3',
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
                                return ScoreScreen();
                              }));
                            },
                            child: const Text('View'),
                          )
                        : ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            onPressed: () async {
                              bool isMatchend = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const TimerScreen();
                              }));
                              print(isMatchend);
                              setState(() {
                                clubmatch3ended = isMatchend;
                              });
                            },
                            child: const Text('Enter Match')),
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
