import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fliersclub/screens/User_Screens/user_match.dart';
import 'package:flutter/material.dart';

class ClubTournaments extends StatefulWidget {
  String tid;
  ClubTournaments({required this.tid});

  @override
  State<ClubTournaments> createState() => _ClubTournamentState();
}

class _ClubTournamentState extends State<ClubTournaments> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Tournaments'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('ClubAdmin')
            .doc(widget.tid)
            .collection('tournaments')
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Tournament available.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) {
              return Card(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blueGrey, Colors.white],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(0.5, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data!.docs[index]['tournamentName'],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) {
                                  return UserMatch(
                                    cid: snapshot.data!.docs[index]['clubid'],
                                    tid: snapshot.data!.docs[index]['id'],
                                  );
                                }),
                              ),
                            );
                          },
                          child: const Text('View'))
                    ],
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
