import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fliersclub/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddTournamentScreen extends StatefulWidget {
  const AddTournamentScreen({super.key});

  @override
  State<AddTournamentScreen> createState() => _AddTournamentScreenState();
}

class _AddTournamentScreenState extends State<AddTournamentScreen> {
  bool isLoading = false;
  final TextEditingController _tournamentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black, title: const Text('Add Tournament')),
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        TextFormField1(
          controller: _tournamentController,
          hintText: 'Tournament Name',
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () async {
              if (_tournamentController.text.isNotEmpty) {
                setState(() {
                  isLoading = true;
                });
                String res = await addTournament(
                    clubid: _auth.currentUser!.uid,
                    status: 'ongoing',
                    tournamentname: _tournamentController.text);
                if (res == 'success') {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Tournament added success')));
                  Navigator.pop(context);
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(res.toString())));
                }
              } else {
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Enter tournament name to proceeed')));
              }
            },
            child: isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : const Text('Add'))
      ]),
    );
  }

  Future<String> addTournament({
    required String clubid,
    required String tournamentname,
    required String status,
  }) async {
    String res = 'error while creating tournament';
    var id = const Uuid().v1();
    try {
      await _firestore
          .collection('ClubAdmin')
          .doc(_auth.currentUser!.uid)
          .collection('tournaments')
          .doc(id)
          .set({
        'id': id,
        'clubid': clubid,
        'tournamentName': tournamentname,
        'status': status
      });
      await _firestore
          .collection('Tournaments')
          .doc(_auth.currentUser!.uid)
          .set({
        'id': id,
        'clubid': clubid,
        'tournamentName': tournamentname,
        'status': status
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
