import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScoreChart extends StatefulWidget {
  String matchid;
  ScoreChart({required this.matchid});

  @override
  State<ScoreChart> createState() => _ScoreChartState();
}

class _ScoreChartState extends State<ScoreChart> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Scorechart'),
      ),
      body: StreamBuilder(
          stream: _firestore
              .collection('ScoreBoard')
              .doc(widget.matchid)
              .snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.data == null) {
              return const Center(
                  child: Text(
                "No Match available.",
                style: TextStyle(color: Colors.white),
              ));
            }
            return SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    snapshot.data!['participantName'],
                    style: const TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Pigeon 1 ' + snapshot.data!['pigeon1time'],
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Pigeon 2 ' + snapshot.data!['pigeon2time'],
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.alarm),
                      Text(snapshot.data!['matchtime'])
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month),
                      Text(snapshot.data!['matchdate'])
                    ],
                  )
                ],
              ),
            );
          })),
    );
  }
}
