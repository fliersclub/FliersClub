import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fliersclub/screens/RefereeScreens/scoreboard.dart';
import 'package:fliersclub/screens/RefereeScreens/timer_screen.dart';
import 'package:flutter/material.dart';

class RefereeHome extends StatefulWidget {
  const RefereeHome({super.key});

  @override
  State<RefereeHome> createState() => _RefereeHomeState();
}

class _RefereeHomeState extends State<RefereeHome> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            AppBar(backgroundColor: Colors.black, title: Text('Referee Home')),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firebaseFirestore
              .collection('Referee')
              .doc(_auth.currentUser!.uid)
              .collection('Matches')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(children: [
                          Container(
                            width: double.infinity,
                            color: Colors.amber[50],
                            child: Center(
                              child: Text(
                                snapshot.data!.docs[index]['tournamentName'],
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Text('Name ' +
                              snapshot.data!.docs[index]['participantName']),
                          Text(
                              'Mobile ' + snapshot.data!.docs[index]['mobile']),
                          Text('Date ' +
                              snapshot.data!.docs[index]['matchdate']),
                          Text('matchtime ' +
                              snapshot.data!.docs[index]['matchtime']),
                          Text('matchplace ' +
                              snapshot.data!.docs[index]['matchplace']),
                          snapshot.data!.docs[index]['matchend'] == false
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) {
                                              return TimerScreen(
                                                matchdata:
                                                    snapshot.data!.docs[index],
                                              );
                                            }),
                                          ),
                                        );
                                      },
                                      child: const Text('View'),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Reject'),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: ((context) {
                                            return ScoreBoard(
                                              matchid: snapshot
                                                  .data!.docs[index]['matchid'],
                                            );
                                          })));
                                        },
                                        child: const Text('View Score'))
                                  ],
                                )
                        ]),
                      ),
                    )
                  ]);
                }),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
