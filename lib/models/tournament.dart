import 'package:cloud_firestore/cloud_firestore.dart';

class Tournament {
  String id;
  String tournamentName;
  String clubid;
  String status;

  Tournament(
      {required this.id,
      required this.tournamentName,
      required this.clubid,
      required this.status});

  Map<String, dynamic> toJson() => {
        'id': id,
        'tournamentName': tournamentName,
        'clubid': clubid,
        'status': status
      };

  static Tournament fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Tournament(
        status: snapshot['status'],
        clubid: snapshot['clubid'],
        id: snapshot['id'],
        tournamentName: snapshot['tournamentName']);
  }
}
