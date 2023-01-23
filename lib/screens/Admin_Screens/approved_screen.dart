import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ApprovedScreen extends StatefulWidget {
  const ApprovedScreen({super.key});

  @override
  State<ApprovedScreen> createState() => _ApprovedScreenState();
}

class _ApprovedScreenState extends State<ApprovedScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('ClubAdmin')
            .where('isApproved', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  return Card(
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
                        Text('Mobile :' + snapshot.data!.docs[index]['mobile']),
                        Text('Address :' +
                            snapshot.data!.docs[index]['address']),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () async {
                              String res = await deleteClub(
                                  id: snapshot.data!.docs[index]['id'],
                                  name: snapshot.data!.docs[index]['clubName']);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(snapshot.data!.docs[index]
                                              ['clubName'] +
                                          ' Deleted successfully ')));
                            },
                            child: Text('Delete Club'))
                      ],
                    )),
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

  Future<String> deleteClub({required String id, required String name}) async {
    String res = 'Error while deleting the club' + name;
    try {
      await _firestore.collection('ClubAdmin').doc(id).delete();
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
