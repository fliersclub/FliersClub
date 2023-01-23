import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fliersclub/screens/User_Screens/club_tournaments.dart';
import 'package:flutter/material.dart';

class ScoreHome extends StatefulWidget {
  const ScoreHome({super.key});

  @override
  State<ScoreHome> createState() => _ScoreHomeState();
}

class _ScoreHomeState extends State<ScoreHome> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text('Clubs')),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('ClubAdmin')
              .where('isApproved', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text(
                "No Clubs available.",
                style: TextStyle(color: Colors.white),
              ));
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: Card(
                          child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return ClubTournaments(
                              tid: snapshot.data!.docs[index]['id'],
                            );
                          })));
                        },
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data!.docs[index]['logo'])),
                        title: Text(snapshot.data!.docs[index]['clubName']),
                        subtitle: Text(snapshot.data!.docs[index]['address']),
                      )),
                    ),
                  );
                }));
          }),
    );
  }
}
