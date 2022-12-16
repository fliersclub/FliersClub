import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fliersclub/models/clubuser.dart';
import 'package:uuid/uuid.dart';

class AuthMethod {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> register({
    required String email,
    required String password,
    required String mobile,
    required String clubName,
    required String address,
    required bool isApproved,
  }) async {
    String res = 'Some error occured';

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      ClubUser clubUser = ClubUser(
          role: 'ClubAdmin',
          id: cred.user!.uid,
          mobile: mobile,
          email: email,
          password: password,
          clubName: clubName,
          address: address,
          isApproved: false);
      await _firestore
          .collection('ClubAdmin')
          .doc(cred.user!.uid)
          .set(clubUser.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> login(
      {required String email,
      required String password,
      required String role}) async {
    String res = 'Error while logging';
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      DocumentSnapshot snap =
          await _firestore.collection(role).doc(cred.user!.uid).get();
      print('snap is' + snap.data().toString());
      res = snap['role'];
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
