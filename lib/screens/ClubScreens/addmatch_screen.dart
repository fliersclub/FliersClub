import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String? selectedDate;
  late TimeOfDay time;
  String timeo = '';
  String? _selectedUmpire;
  List<String> _umpires = [
    'UMPIRE 1',
    'UMPIRE 2',
    'UMPIRE 3',
    'UMPIRE 4',
  ];
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Add a match'),
      ),
      body: Padding(
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
                hintText: selectedDate == null ? 'Match Date' : selectedDate,
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
                  borderRadius: BorderRadius.all(Radius.circular(21))),
              width: double.infinity,
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: DropdownButton<String>(
                      isExpanded: true,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      focusColor: Colors.white,
                      elevation: 0,
                      hint: _selectedUmpire == null
                          ? Text('Select Umpire')
                          : Text(_selectedUmpire!),
                      // value: _selectedUmpire,
                      items: _umpires
                          .map((String value) => DropdownMenuItem(
                                alignment: Alignment.center,
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedUmpire = value!;
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                icon: const Icon(Icons.alarm),
                label: const Text('Schedule Match'),
                onPressed: () async {
                  String res = await addMatch(
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(res.toString())));
                  }

                  print(_selectedUmpire);
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
        lastDate: DateTime(2030));

    if (_datePicker != null && _datePicker != null) {
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy').format(_datePicker);
        ;
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
      required String date,
      required String time,
      required String place,
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
        'participantName': participantName,
        'mobile': number,
        'matchdate': date,
        'matchtime': time,
        'matchplace': place,
        'matchumpire': umpire,
        'tournamentid': tournamentid
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
