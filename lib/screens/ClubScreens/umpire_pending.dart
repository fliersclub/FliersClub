import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fliersclub/models/referee.dart';
import 'package:flutter/material.dart';

class UmpirePending extends StatefulWidget {
  const UmpirePending({super.key});

  @override
  State<UmpirePending> createState() => _UmpirePendingState();
}

class _UmpirePendingState extends State<UmpirePending> {
  List<dynamic> documentIds = [];
  List<String> joinedClubs = [];
  int length = 0;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('Referee')
            .where('interestedClubs', arrayContains: _auth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                documentIds = snapshot.data!.docs[index]['joinedClubs'];

                return Container(
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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Name: ' + snapshot.data!.docs[index]['name']),
                        Text('Mobile: ' + snapshot.data!.docs[index]['mobile']),
                        Text('address: ' +
                            snapshot.data!.docs[index]['address']),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                String res1 = await addReferee(
                                  pic: snapshot.data!.docs[index]['pic'],
                                  email: snapshot.data!.docs[index]['email'],
                                  password: snapshot.data!.docs[index]
                                      ['password'],
                                  id: snapshot.data!.docs[index]['id'],
                                  name: snapshot.data!.docs[index]['name'],
                                  address: snapshot.data!.docs[index]
                                      ['address'],
                                  mobile: snapshot.data!.docs[index]['mobile'],
                                  interestedclubs: snapshot.data!.docs[index]
                                      ['interestedClubs'],
                                  joinedclubs: snapshot.data!.docs[index]
                                      ['joinedClubs'],
                                );
                                String res2 = await deleteRefereeRequest(
                                    id: snapshot.data!.docs[index]['id']);
                                print(res1);
                                print(res2);
                              },
                              child: const Text(
                                'Accept',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await _firestore
                                    .collection('Referee')
                                    .doc(snapshot.data!.docs[index]['id'])
                                    .update({
                                  'interestedClubs': FieldValue.arrayRemove(
                                      [_auth.currentUser!.uid])
                                });
                              },
                              child: const Text(
                                'Reject',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        )
                      ]),
                );
              }),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }

  Future<String> addReferee({
    required String pic,
    required String email,
    required String password,
    required String id,
    required String name,
    required String mobile,
    required String address,
    required List interestedclubs,
    required List joinedclubs,
  }) async {
    String res = 'Error while adding referee to club';
    try {
      Referee referee = Referee(
          pic: pic,
          role: 'referee',
          email: email,
          password: password,
          id: id,
          name: name,
          mobile: mobile,
          address: address,
          interestedclubs: interestedclubs,
          joinedClubs: joinedclubs);
      await _firestore
          .collection('ClubAdmin')
          .doc(_auth.currentUser!.uid)
          .collection('referees')
          .doc(id)
          .set(referee.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> deleteRefereeRequest({required String id}) async {
    String res = 'Error while deleting request';
    try {
      DocumentReference docRef = _firestore.collection('Referee').doc(id);
      docRef.update({
        'interestedClubs': FieldValue.arrayRemove([_auth.currentUser!.uid]),
        'joinedClubs': FieldValue.arrayUnion([_auth.currentUser!.uid])
      });
      DocumentReference docRef2 = _firestore
          .collection('ClubAdmin')
          .doc(_auth.currentUser!.uid)
          .collection('referees')
          .doc(id);

      docRef2.update({
        'interestedClubs': FieldValue.arrayRemove([_auth.currentUser!.uid]),
        'joinedClubs': FieldValue.arrayUnion([_auth.currentUser!.uid])
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // getJoined() async {
  //   try {
  //     CollectionReference collection = _firestore.collection('ClubAdmin');
  //     documentIds.forEach((element) async {
  //       QuerySnapshot snapshot =
  //           await collection.where('id', isEqualTo: element).get();
  //       setState(() {
  //         joinedClubs.add(snapshot.docs[0]['clubName']);
  //       });
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
