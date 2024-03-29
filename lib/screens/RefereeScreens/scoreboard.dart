import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatefulWidget {
  late String matchid;
  ScoreBoard({required this.matchid});
  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('ScoreBoard'),
      ),
      body: StreamBuilder(
        stream: _firebaseFirestore
            .collection('ScoreBoard')
            .doc(widget.matchid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Container(
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.black,
                            child: Center(
                              child: Text(
                                snapshot.data!.get('tournamentName'),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.date_range,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            snapshot.data!.get('matchdate') + ' , ',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.timer,
                            color: Colors.white,
                          ),
                          Text(
                            snapshot.data!.get('matchtime'),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            snapshot.data!.get('participantName'),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      snapshot.data!.get('cancelled') == false &&
                              snapshot.data!.get('chance') == ''
                          ? Column(
                              children: [
                                Text(
                                  'Winner Pigeon is ' +
                                      snapshot.data!.get('winnerPigeon'),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          : snapshot.data!.get('cancelled') == true
                              ? Text(
                                  'Match Cancelled due to ' +
                                      snapshot.data!.get('cancelreason'),
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18),
                                )
                              : SizedBox(),
                      const SizedBox(
                        height: 15,
                      ),
                      snapshot.data!.get('chance') == ''
                          ? Column(children: [
                              Text(
                                'Pigoen 1 time is  ' +
                                    snapshot.data!.get('pigeon1time'),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Pigoen 2 time is ' +
                                    snapshot.data!.get('pigeon2time'),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ])
                          : Container(
                              color: Colors.yellow,
                              child: Text(
                                'Chance Given due to ' +
                                    snapshot.data!.get('chance') +
                                    ' at ' +
                                    snapshot.data!.get('chanceTime'),
                                style: const TextStyle(fontSize: 16),
                              )),
                      const SizedBox(
                        height: 15,
                      ),
                    ]),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
