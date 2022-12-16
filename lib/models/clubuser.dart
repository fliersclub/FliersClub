import 'package:cloud_firestore/cloud_firestore.dart';

class ClubUser {
  String? id;
  String? email;
  String? password;
  String? clubName;
  String? address;
  String? mobile;
  String? role;
  bool? isApproved;

  ClubUser(
      {required this.id,
      required this.role,
      required this.mobile,
      required this.email,
      required this.password,
      required this.clubName,
      required this.address,
      required this.isApproved});

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'email': email,
        'password': password,
        'clubName': clubName,
        'address': address,
        'mobile': mobile,
        'isApproved': isApproved
      };

  static ClubUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ClubUser(
        id: snapshot['id'],
        role: snapshot['role'],
        address: snapshot['address'],
        clubName: snapshot['clubName'],
        email: snapshot['email'],
        isApproved: snapshot['isApproved'],
        mobile: snapshot['mobile'],
        password: snapshot['password']);
  }
}
