import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fliersclub/models/clubuser.dart';
import 'package:fliersclub/screens/AuthScreen/landing_screen.dart';
import 'package:fliersclub/screens/ClubScreens/add_tournament_screen.dart';
import 'package:fliersclub/screens/ClubScreens/tournment_screen2.dart';
import 'package:flutter/material.dart';

class TournamentScreen1 extends StatefulWidget {
  const TournamentScreen1({super.key});

  @override
  State<TournamentScreen1> createState() => _TournamentScreen1State();
}

class _TournamentScreen1State extends State<TournamentScreen1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('ClubAdmin'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: ((context) {
                    return LandingScreen();
                  })), (route) => false);
                },
                icon: Icon(Icons.exit_to_app))
          ]),
      body: StreamBuilder(
        stream: firestore
            .collection('ClubAdmin')
            .doc(_auth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot1) {
          return StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('ClubAdmin')
                .doc(_auth.currentUser!.uid)
                .collection('tournaments')
                .snapshots(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          return tournament(
                              tournament: snapshot.data!.docs[index],
                              context: context,
                              tournamentname: snapshot.data!.docs[index]
                                  ['tournamentName'],
                              status: snapshot.data!.docs[index]['status']);
                        }),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 35,
                            width: 150,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple),
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                              label: const Text('UMPIRE'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 35,
                            width: 150,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple),
                              onPressed: () {
                                if (snapshot1.data!.get('isApproved') == true) {
                                  print('yes he can');
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: ((context) {
                                    return AddTournamentScreen();
                                  })));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return AlertDialog(
                                        content: const Text(
                                          'Your Club is not Approved by admin',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.black),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('OK'),
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                                  );
                                }
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Tournament'),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text('No Tournaments'),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
          );
        },
      ),
    );
  }

  Container tournament(
      {required BuildContext context,
      required var tournament,
      required String tournamentname,
      required String status}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Card(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Tournament :' + tournamentname,
              style: TextStyle(fontSize: 20),
            ),
          ),
          const Divider(),
          Text(
            'Status: ' + status,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TournamentScreen2(
                    tournament: tournament,
                  );
                }));
              },
              child: const Text('View Tournament')),
          const SizedBox(
            height: 5,
          ),
        ],
      )),
    );
  }
}
