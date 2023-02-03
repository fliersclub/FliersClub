import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashed_line/dashed_line.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LiveDetail extends StatefulWidget {
  String matchid;
  LiveDetail({required this.matchid});

  @override
  State<LiveDetail> createState() => _LiveDetailState();
}

class _LiveDetailState extends State<LiveDetail> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: StreamBuilder<DocumentSnapshot>(
          stream: _firestore
              .collection('LiveMatches')
              .doc(widget.matchid)
              .snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                reverse: true,
                children: [
                  Center(
                      child: Text(
                    'Start Time ' +
                        snapshot.data!.get(
                          'matchstarttime',
                        ),
                    style: const TextStyle(fontSize: 25),
                  )),
                  for (int i = 0;
                      i < snapshot.data!.get('pigeon1sightedAt').length;
                      i++)
                    if (i == snapshot.data!.get('pigeon1sightedAt').length - 1)
                      Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.remove_red_eye),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('sighted at ' +
                                    snapshot.data!.get('pigeon1sightedAt')[i]),
                              ],
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage:
                                  AssetImage('assets/whitefly.png'),
                            )
                          ],
                        ),
                      )
                    else
                      Center(
                        child: Column(
                          children: [
                            Container(
                              color: Colors.blue,
                              width: 10,
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.remove_red_eye),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('sighted at ' +
                                    snapshot.data!.get('pigeon1sightedAt')[i]),
                              ],
                            ),
                          ],
                        ),
                      )
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          })),
    );
  }
}
