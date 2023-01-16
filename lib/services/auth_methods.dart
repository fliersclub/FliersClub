import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fliersclub/models/clubuser.dart';
import 'package:uuid/uuid.dart';

class AuthMethod {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> register({
    required file,
    required String email,
    required String password,
    required String mobile,
    required String clubName,
    required String address,
    required bool isApproved,
  }) async {
    String res = 'Some error occured';
    if (file == null) {
      res = 'Club logo is mandatory';
    } else {
      try {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await uploadImageToStorage(
            childName: 'RefereeprofilePics',
            file: file,
            isPost: false,
            id: cred.user!.uid);
        ClubUser clubUser = ClubUser(
            logo: photoUrl,
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
        await _firestore.collection('roles').doc(cred.user!.uid).set({
          'role': 'ClubAdmin',
        });
        res = 'success';
      } catch (e) {
        res = e.toString();
      }
    }

    return res;
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = 'Error while logging';
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(cred.user!.email);
      print(cred.user!.uid);
      DocumentSnapshot snapshot =
          await _firestore.collection('roles').doc(cred.user!.uid).get();
      String role = snapshot.get('role');
      if (role == 'Referee') {
        DocumentSnapshot snap =
            await _firestore.collection('Referee').doc(cred.user!.uid).get();
        res = snap['role'];
      } else {
        DocumentSnapshot snap =
            await _firestore.collection(role).doc(cred.user!.uid).get();
        print('snap is' + snap.data().toString());
        res = snap['role'];
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> uploadImageToStorage(
      {required String childName,
      required Uint8List file,
      required bool isPost,
      required id}) async {
    Reference ref = _firebaseStorage
        .ref()
        .child(childName)
        .child(_firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
