import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fliersclub/widgets/textformfield.dart';
import 'package:flutter/material.dart';

class RefereeRegScreen extends StatefulWidget {
  const RefereeRegScreen({super.key});

  @override
  State<RefereeRegScreen> createState() => _RefereeRegScreenState();
}

class _RefereeRegScreenState extends State<RefereeRegScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    submit();
  }

  final List<String> _selectedClubs = [];
  final List<String> _selectedClubsName = [];
  final List<Map<String, dynamic>> clubs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Referee Registration'),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField1(
            hintText: 'Name',
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField1(
            hintText: 'Mobile',
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField1(
            hintText: 'address',
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: ((context) {
                    return StatefulBuilder(
                      builder: ((context, setState) {
                        return AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('cancel')),
                            TextButton(
                                onPressed: () {
                                  refresh();
                                  print(_selectedClubs);
                                  Navigator.pop(context);
                                },
                                child: const Text('submit'))
                          ],
                          title: const Text('Select your interested Clubs'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: clubs
                                  .map((club) => CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(club['name']),
                                      value: _selectedClubs
                                          .contains(club['id'].toString()),
                                      onChanged: ((isChecked) {
                                        setState(() {
                                          if (isChecked!) {
                                            _selectedClubs
                                                .add(club['id'].toString());
                                            _selectedClubsName
                                                .add(club['name']);
                                            print('added');
                                          } else {
                                            _selectedClubs
                                                .remove(club['id'].toString());
                                            _selectedClubsName
                                                .remove(club['name']);
                                            print('removed');
                                          }
                                        });
                                      })))
                                  .toList(),
                            ),
                          ),
                        );
                      }),
                    );
                  }));
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              height: 50,
              width: 250,
              child: const Card(
                  child: Center(
                      child: Text(
                'Select Interested Clubs',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ))),
            ),
          ),
          Wrap(
              children: _selectedClubsName
                  .map(
                    (e) => Chip(
                      label: Text(e),
                    ),
                  )
                  .toList()),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () {
              print('reg');
              print(_selectedClubs);
              print(_selectedClubsName);
            },
            child: const Text('Register'),
          )
        ]),
      ),
    );
  }

  void submit() async {
    String res = 'Some error occured while registration';
    try {
      CollectionReference clubcl = await _firestore.collection('ClubAdmin');
      clubcl.get().then(
            (value) => value.docs.forEach((element) {
              print(element.get('clubName'));
              String name = element.get('clubName');
              String id = element.get('id');
              clubs.add({'name': name, 'id': id});
            }),
          );
    } catch (e) {
      print(e.toString());
    }
  }

  void refresh() {
    setState(() {});
  }
}
