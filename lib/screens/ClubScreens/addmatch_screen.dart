import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fliersclub/models/selectedref.dart';
import 'package:fliersclub/models/tournament.dart';
import 'package:fliersclub/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddMatchScreen extends StatefulWidget {
  var tournament;
  AddMatchScreen({required this.tournament});

  @override
  State<AddMatchScreen> createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> {
  bool isLoading = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String? selectedDate;
  late TimeOfDay time;
  List rdates = [];
  String timeo = '';
  String _selectedUmpire = '';
  String _selectedUmpireName = '';
  List<SelectedRef> _umpires = [];
  late TimeOfDay picked;
  TextEditingController _matchNameController = TextEditingController();
  TextEditingController _matchDateController = TextEditingController();
  TextEditingController _matchTimeController = TextEditingController();
  TextEditingController _matchPlaceController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time = TimeOfDay.now();
    print(widget.tournament);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Add a match'),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField1(
                      hintText: _matchNameController.text.isEmpty
                          ? 'Participant Name'
                          : _matchNameController.text,
                      controller: _matchNameController),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField1(
                      hintText: _mobileController.text.isEmpty
                          ? 'Mobile Number'
                          : _mobileController.text,
                      controller: _mobileController),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField1(
                      readonly: true,
                      controller: _matchDateController,
                      hintText:
                          selectedDate == null ? 'Match Date' : selectedDate,
                      ontap: () {
                        selectDate(context);
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField1(
                      readonly: true,
                      controller: _matchTimeController,
                      hintText: timeo.isEmpty ? 'Match Time' : timeo.toString(),
                      ontap: () {
                        selectTime(context);
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField1(
                      hintText: _matchPlaceController.text.isEmpty
                          ? 'Match Place'
                          : _matchPlaceController.text,
                      controller: _matchPlaceController),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlueAccent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(21))),
                    width: double.infinity,
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: DropdownButton(
                            isExpanded: true,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            focusColor: Colors.white,
                            elevation: 0,
                            hint: _selectedUmpireName.isEmpty
                                ? const Text('Select Umpire')
                                : Text(_selectedUmpireName),
                            // value: _selectedUmpire,
                            items: _umpires.map(((SelectedRef ref) {
                              return DropdownMenuItem(
                                value: ref,
                                child: Text(ref.name),
                              );
                            })).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedUmpire = value!.id;
                                _selectedUmpireName = value.name;
                                rdates.clear();
                                refereeCheck();
                              });
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      icon: const Icon(Icons.alarm),
                      label: const Text('Schedule Match'),
                      onPressed: () async {
                        refereeCheck();

                        if (rdates.contains(selectedDate)) {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: Text(
                                    'Alert!!!',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: Text(
                                      'Referee is not available in selected date ! please change match date or referee'),
                                  actions: [
                                    Center(
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK')),
                                    )
                                  ],
                                );
                              }));
                        } else {
                          String res = await addMatch(
                              umpname: _selectedUmpireName,
                              tournamentname:
                                  widget.tournament['tournamentName'],
                              tournamentid: widget.tournament['id'],
                              participantName: _matchNameController.text,
                              number: _mobileController.text,
                              date: selectedDate.toString(),
                              place: _matchPlaceController.text,
                              time: timeo.toString(),
                              umpire: _selectedUmpire.toString());

                          if (res == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Match scheduled successfully')));
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  res.toString(),
                                ),
                              ),
                            );
                          }
                        }

                        print('Selected Umpire is ' + _selectedUmpire);
                      },
                    ),
                  )
                ],
              )),
            ),
    );
  }

  void selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );

    if (_datePicker != null && _datePicker != null) {
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy').format(_datePicker);
      });
      print(_date.toString());
    }
  }

  void selectTime(BuildContext context) async {
    String AM_PM = '';
    picked =
        (await showTimePicker(context: context, initialTime: TimeOfDay.now()))!;

    if (picked != null) {
      setState(() {
        time = picked;
        if (picked.hour < 12) {
          AM_PM = ' AM';
        } else {
          AM_PM = ' PM';
        }
        timeo = picked.hourOfPeriod.toString().padLeft(2, '0') +
            ":" +
            picked.minute.toString().padLeft(2, '0') +
            AM_PM;

        print(timeo);
      });
    }
  }

  Future<String> addMatch(
      {required String participantName,
      required String number,
      required tournamentid,
      required tournamentname,
      required String date,
      required String time,
      required String place,
      required String umpname,
      required String umpire}) async {
    String res = 'Error while adding match';
    String id = Uuid().v1();
    try {
      await _firestore
          .collection('ClubAdmin')
          .doc(_auth.currentUser!.uid)
          .collection('tournaments')
          .doc(widget.tournament['id'])
          .collection('matches')
          .doc(id)
          .set({
        'mid': id,
        'participantName': participantName,
        'mobile': number,
        'matchdate': date,
        'matchend': false,
        'matchtime': time,
        'cid': _auth.currentUser!.uid,
        'matchplace': place,
        'umpname': umpname,
        'matchumpire': umpire,
        'tournamentid': tournamentid,
        'tournamentName': tournamentname,
      });
      await _firestore
          .collection('Referee')
          .doc(umpire)
          .collection('Matches')
          .doc(id)
          .set({
        'matchid': id,
        'participantName': participantName,
        'matchend': false,
        'mobile': number,
        'cid': _auth.currentUser!.uid,
        'matchdate': date,
        'matchtime': time,
        'matchplace': place,
        'matchumpire': umpire,
        'tournamentid': tournamentid,
        'tournamentName': tournamentname,
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    String res = 'Some error occured while registration';

    try {
      CollectionReference ref = _firestore
          .collection('ClubAdmin')
          .doc(_auth.currentUser!.uid)
          .collection('referees');
      ref.get().then(
            (value) => value.docs.forEach((element) {
              String name = element.get('name');
              String id = element.get('id');
              SelectedRef selectedRef = SelectedRef(id: id, name: name);

              setState(() {
                _umpires.add(selectedRef);
              });
            }),
          );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      print(e.toString());
    }
  }

  refereeCheck() async {
    Stream<QuerySnapshot> snapshots = _firestore
        .collection('Referee')
        .doc(_selectedUmpire)
        .collection('Matches')
        .snapshots();
    snapshots.listen((snapshot) {
      for (var document in snapshot.docs) {
        setState(() {
          rdates.add(document.get('matchdate'));
        });
      }
    });
  }
}
