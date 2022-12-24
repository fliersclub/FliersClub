import 'package:cloud_firestore/cloud_firestore.dart';

class Referee {
  String id;
  String email;
  String role;
  String password;
  String name;
  String mobile;
  String address;
  List interestedclubs;
  List joinedClubs;

  Referee(
      {required this.id,
      required this.role,
      required this.email,
      required this.password,
      required this.name,
      required this.mobile,
      required this.address,
      required this.interestedclubs,
      required this.joinedClubs});

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'name': name,
        'email': email,
        'password': password,
        'mobile': mobile,
        'address': address,
        'interestedClubs': interestedclubs,
        'joinedClubs': joinedClubs
      };

  static Referee fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Referee(
        role: snapshot['role'],
        password: snapshot['password'],
        email: snapshot['email'],
        id: snapshot['id'],
        name: snapshot['name'],
        address: snapshot['address'],
        mobile: snapshot['mobile'],
        joinedClubs: snapshot['joinedClubs'],
        interestedclubs: snapshot['interestedClubs']);
  }
}
