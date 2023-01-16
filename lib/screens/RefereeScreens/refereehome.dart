import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fliersclub/models/referee.dart';
import 'package:fliersclub/screens/AuthScreen/landing_screen.dart';
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
  bool? isLoading = false;
  var referee;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.grey,
          child: Column(children: [
            Container(
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: isLoading == true
                      ? const AssetImage('assets/nouser.png') as ImageProvider
                      : NetworkImage(referee['pic']),
                  radius: 75,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  referee['name'],
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Colors.white,
                )
              ]),
            ),
            const ListTile(
              title: Text('Profile Settings'),
            ),
            const Divider(
              color: Colors.white,
            ),
            const ListTile(
              title: Text('Logout'),
            ),
          ]),
        ),
        appBar: AppBar(actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                _auth.signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return LandingScreen();
                  },
                ), (route) => false);
              },
              child: const Icon(Icons.logout))
        ], backgroundColor: Colors.black, title: const Text('Referee Home')),
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
                            child: Center(
                              child: Text(
                                snapshot.data!.docs[index]['tournamentName'],
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Text('Name ' +
                              snapshot.data!.docs[index]['participantName']),
                          Text(
                              'Mobile ' + snapshot.data!.docs[index]['mobile']),
                          Text('Date ' +
                              snapshot.data!.docs[index]['matchdate']),
                          Text('matchplace ' +
                              snapshot.data!.docs[index]['matchplace']),
                          snapshot.data!.docs[index]['chance'] == ''
                              ? SizedBox()
                              : Container(
                                  width: double.infinity,
                                  color: Colors.lightBlueAccent,
                                  child: Center(
                                    child: Text(
                                      snapshot.data!.docs[index]['chance'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )),
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
                                ),
                          Divider(
                            color: Colors.black,
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

  void getUser() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection('Referee')
        .doc(_auth.currentUser!.uid)
        .get();
    setState(() {
      referee = snapshot.data();
    });
  }
}
