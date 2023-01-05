import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScoreBoard extends StatefulWidget {
  late String matchid;
  ScoreBoard({required this.matchid});
  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('ScoreBoard')),
        body: StreamBuilder(
          stream: _firebaseFirestore
              .collection('ScoreBoard')
              .doc(widget.matchid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Container(
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(snapshot.data!.get('tournamentName')),
                        SizedBox(
                          height: 15,
                        ),
                        Text(snapshot.data!.get('participantName')),
                        SizedBox(
                          height: 15,
                        ),
                        Text('winner pigeon is ' +
                            snapshot.data!.get('winnerPigeon')),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Pigoen 1 time is  ' +
                            snapshot.data!.get('pigeon1time')),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Pigoen 2 time is ' +
                            snapshot.data!.get('pigeon2time')),
                        SizedBox(
                          height: 15,
                        ),
                      ]),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
