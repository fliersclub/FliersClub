import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fliersclub/screens/AuthScreen/landing_screen.dart';
import 'package:fliersclub/screens/User_Screens/club_tournaments.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: ((context) {
                  return const LandingScreen();
                }),
              ), (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('ClubAdmin')
            .where('isApproved', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No Clubs Registered'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
