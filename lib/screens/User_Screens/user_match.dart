import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fliersclub/screens/User_Screens/score_chart.dart';
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
                  onTap: () {
                    if (snapshot.data!.docs[index]['matchend'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ScoreChart(
                              matchid: snapshot.data!.docs[index]['mid'],
                            );
                          },
                        ),
                      );
                    } else if (snapshot.data!.docs[index]['matchend'] ==
                        false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Match Not Completed'),
                        ),
                      );
                    }
                  },
                  title: Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(snapshot.data!.docs[index]['participantName']),
                      const Spacer(),
                      Row(
                        children: const [
                          Text(
                            'Live',
                            style: TextStyle(color: Colors.red),
                          ),
                          Icon(
                            Icons.live_tv,
                            color: Colors.red,
                          )
                        ],
                      )
                    ],
                  ),
                  subtitle: Row(children: []),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
