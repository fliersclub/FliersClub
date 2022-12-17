import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('ClubAdmin')
              .where('isApproved', isEqualTo: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return Expanded(
                      child: Card(
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Name of the club :' +
                                  snapshot.data!.docs[index]['clubName'],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Mobile :' +
                                snapshot.data!.docs[index]['mobile']),
                            Text('Address :' +
                                snapshot.data!.docs[index]['address']),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightGreen),
                                onPressed: () async {
                                  String res = await approve(
                                      id: snapshot.data!.docs[index]['id'],
                                      clubName: snapshot.data!.docs[index]
                                          ['clubName']);
                                  if (res == 'success') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(snapshot.data!
                                                    .docs[index]['clubName'] +
                                                ' Approved successfully ')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(res)));
                                  }
                                },
                                child: const Text('Approve'))
                          ],
                        )),
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
      ),
    );
  }

  Future<String> approve({required String id, required String clubName}) async {
    String res = 'Error while Approving';
    try {
      await _firestore
          .collection('ClubAdmin')
          .doc(id)
          .update({'isApproved': true});
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
