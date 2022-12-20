import 'package:cloud_firestore/cloud_firestore.dart';

class Referee {
  String id;
  String name;
  String mobile;
  String address;
  List interestedclubs;
  List joinedClubs;

  Referee(
      {required this.id,
      required this.name,
      required this.mobile,
      required this.address,
      required this.interestedclubs,
      required this.joinedClubs});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mobile': mobile,
        'address': address,
        'interestedClubs': interestedclubs,
        'joinedClubs': joinedClubs
      };

  static Referee fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Referee(
        id: snapshot['id'],
        name: snapshot['name'],
        address: snapshot['address'],
        mobile: snapshot['mobile'],
        joinedClubs: snapshot['joinedClubs'],
        interestedclubs: snapshot['interestedClubs']);
  }
}
