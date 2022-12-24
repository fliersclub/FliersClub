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
                  return Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Name: ' + snapshot.data!.docs[index]['name']),
                          Text('Mobile: ' +
                              snapshot.data!.docs[index]['mobile']),
                          Text('address: ' +
                              snapshot.data!.docs[index]['address']),
                          const Text(
                            'JoinedClubs',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          for (int i = 0; i < joinedClubs.length; i++)
                            Text(joinedClubs[i]),
                        ]),
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
