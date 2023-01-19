import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        backgroundColor: Colors.black,
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
                  isLoading == true ? 'loading...' : referee['name'],
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
              .orderBy('matchdate', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
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
                            Text('Mobile ' +
                                snapshot.data!.docs[index]['mobile']),
                            Text('Date ' +
                                snapshot.data!.docs[index]['matchdate']),
                            Text('matchplace ' +
                                snapshot.data!.docs[index]['matchplace']),
                            snapshot.data!.docs[index]['cancelled'] == true
                                ? Container(
                                    height: 30,
                                    width: double.infinity,
                                    color: Colors.red,
                                    child: Center(
                                      child: Text(
                                        'Cancelled',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                : snapshot.data!.docs[index]['matchend'] ==
                                            true &&
                                        snapshot.data!.docs[index]['chance'] ==
                                            ''
                                    ? Container(
                                        height: 30,
                                        width: double.infinity,
                                        color: Colors.blue,
                                        child: const Center(
                                          child: Text(
                                            'Completed',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                            snapshot.data!.docs[index]['chance'] == ''
                                ? const SizedBox()
                                : Container(
                                    height: 30,
                                    width: double.infinity,
                                    color: Colors.yellow,
                                    child: Center(
                                      child: Text(
                                        snapshot.data!.docs[index]['chance'],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                            snapshot.data!.docs[index]['matchend'] == false
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueGrey),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: ((context) {
                                                return TimerScreen(
                                                  matchdata: snapshot
                                                      .data!.docs[index],
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
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueGrey),
                                        onPressed: () {},
                                        child: const Text('Reject'),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueGrey),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: ((context) {
                                                return ScoreBoard(
                                                  matchid: snapshot.data!
                                                      .docs[index]['matchid'],
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                        child: const Text('View Score'),
                                      ),
                                    ],
                                  ),
                          ]),
                        ),
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
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection('Referee')
        .doc(_auth.currentUser!.uid)
        .get();
    setState(() {
      referee = snapshot.data();
    });
    setState(() {
      isLoading = false;
    });
  }
}
