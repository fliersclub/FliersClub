import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UmpireApproved extends StatefulWidget {
  const UmpireApproved({super.key});

  @override
  State<UmpireApproved> createState() => _UmpireApprovedState();
}

class _UmpireApprovedState extends State<UmpireApproved> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<dynamic> documentIds = [];
  List<String> joinedClubs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 1),
      () {
        setState(() {
          getJoined();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('ClubAdmin')
            .doc(_auth.currentUser!.uid)
            .collection('referees')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  print(snapshot.data!.docs[index]['joinedClubs']);
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.grey,
                                Colors.lightBlueAccent,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(0.5, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data!.docs[index]['pic']),
                              radius: 39,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Name: ' +
                                        snapshot.data!.docs[index]['name'],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Mobile: ' +
                                        snapshot.data!.docs[index]['mobile'],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'address: ' +
                                        snapshot.data!.docs[index]['address'],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  )
                                ]),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('View'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  getJoined() async {
    try {
      CollectionReference collection = _firestore.collection('ClubAdmin');
      documentIds.forEach((element) async {
        QuerySnapshot snapshot =
            await collection.where('id', isEqualTo: element).get();
        setState(() {
          joinedClubs.add(snapshot.docs[0]['clubName']);
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
