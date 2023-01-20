import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserMatch extends StatefulWidget {
  String cid;
  String tid;
  UserMatch({required this.cid, required this.tid});
  @override
  State<UserMatch> createState() => _UserMatchState();
}

class _UserMatchState extends State<UserMatch> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Matches'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('ClubAdmin')
              .doc(widget.cid)
              .collection('tournaments')
              .doc(widget.tid)
              .collection('matches')
              .snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text(
                "No Match available.",
                style: TextStyle(color: Colors.white),
              ));
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data!.docs[index]['participantName']),
                  ),
                );
              },
            );
          })),
    );
  }
}
