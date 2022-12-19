import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fliersclub/screens/ClubScreens/addmatch_screen.dart';
import 'package:fliersclub/screens/ClubScreens/fixture_screen.dart';
import 'package:fliersclub/screens/ClubScreens/timer_screen.dart';
import 'package:flutter/material.dart';

class TournamentScreen2 extends StatefulWidget {
  var tournament;
  TournamentScreen2({required this.tournament});
  @override
  State<TournamentScreen2> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen2> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.tournament['tournamentName']);
  }

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
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == null) {
              return Center(
                child: Text('No matches for this tournament'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    child: Card(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Match $index'),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Name: ' +
                                    snapshot.data!.docs[index]
                                        ['participantName'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Mobile: ' +
                                    snapshot.data!.docs[index]['mobile'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Place: ' +
                                    snapshot.data!.docs[index]['matchplace'],
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Time: ' +
                                          snapshot.data!.docs[index]
                                              ['matchtime'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: clubmatch1ended == true
                                  ? ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ScoreScreen();
                                        }));
                                      },
                                      child: Text('View'))
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green),
                                      onPressed: () async {
                                        bool isMatchend = await Navigator.push(
                                            context, MaterialPageRoute(
                                                builder: (context) {
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
                  );
                },
              );
            }
          },
        ));
  }
}
