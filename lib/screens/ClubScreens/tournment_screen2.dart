import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fliersclub/screens/ClubScreens/addmatch_screen.dart';
import 'package:fliersclub/screens/ClubScreens/fixture_screen.dart';
import 'package:fliersclub/screens/RefereeScreens/scoreboard.dart';
import 'package:fliersclub/screens/RefereeScreens/timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TournamentScreen2 extends StatefulWidget {
  var tournament;
  TournamentScreen2({required this.tournament});
  @override
  State<TournamentScreen2> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen2> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String date1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.tournament['tournamentName']);
    setState(() {
      DateTime date = DateTime.now();
      date1 = DateFormat('dd-MM-yyyy').format(date);
    });
  }

  bool clubmatch1ended = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddMatchScreen(
                  tournament: widget.tournament,
                );
              }));
            },
            child: const Icon(Icons.add)),
        appBar: AppBar(
          title: Text(widget.tournament['tournamentName']),
          backgroundColor: Colors.black,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('ClubAdmin')
              .doc(_auth.currentUser!.uid)
              .collection('tournaments')
              .doc(widget.tournament['id'])
              .collection('matches')
              .orderBy('matchdate', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No matches added for this tournament'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 87, 1, 136),
                            Color.fromARGB(255, 172, 137, 204),
                          ],
                        ),
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Name: ' +
                                    snapshot.data!.docs[index]
                                        ['participantName'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Mobile: ' +
                                    snapshot.data!.docs[index]['mobile'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Place: ' +
                                    snapshot.data!.docs[index]['matchplace'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Date: ' +
                                          snapshot.data!.docs[index]
                                              ['matchdate'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Referee: ' +
                                              snapshot.data!.docs[index]
                                                  ['umpname'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]
                                              ['matchumpire'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                            snapshot.data!.docs[index]['matchend'] == true
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green),
                                        onPressed: () async {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: ((context) {
                                            return ScoreBoard(
                                                matchid: snapshot
                                                    .data!.docs[index]['mid']);
                                          })));
                                        },
                                        child: const Text('View Score')),
                                  )
                                : snapshot.data!.docs[index]['matchdate'] ==
                                        date1
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.green),
                                            onPressed: () async {},
                                            child: Text('Match Today at ' +
                                                snapshot.data!.docs[index]
                                                    ['matchtime'])),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.green),
                                          onPressed: () async {},
                                          child: Text('Scheduled on ' +
                                              snapshot.data!.docs[index]
                                                  ['matchdate']),
                                        ),
                                      )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              );
            }
          },
        ));
  }
}










//  Padding(
//                               padding: const EdgeInsets.only(bottom: 10),
//                               child: clubmatch1ended == true
//                                   ? ElevatedButton(
//                                       onPressed: () {
//                                         Navigator.push(context,
//                                             MaterialPageRoute(
//                                                 builder: (context) {
//                                           return ScoreScreen();
//                                         }));
//                                       },
//                                       child: Text('View'))
//                                   : ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                           primary: Colors.green),
//                                       onPressed: () async {
//                                         bool isMatchend = await Navigator.push(
//                                             context, MaterialPageRoute(
//                                                 builder: (context) {
//                                           return TimerScreen();
//                                         }));
//                                         print(isMatchend);
//                                         setState(() {
//                                           clubmatch1ended = isMatchend;
//                                         });
//                                       },
//                                       child: Text('Enter Match')),
//                             )