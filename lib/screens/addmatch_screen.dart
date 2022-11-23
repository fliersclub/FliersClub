import 'package:fliersclub/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class AddMatchScreen extends StatefulWidget {
  const AddMatchScreen({super.key});

  @override
  State<AddMatchScreen> createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> {
  String _date = DateFormat('dd-MM-yyyy').format(DateTime.now());
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Add a match'),
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
                label: 'Match Name', controller: _matchNameController),
            const SizedBox(
              height: 5,
            ),
            TextFormField1(
                label: 'Match Date',
                readonly: true,
                controller: _matchDateController,
                hintText: _date.toString(),
                ontap: () {
                  selectDate(context);
                }),
            const SizedBox(
              height: 5,
            ),
            TextFormField1(
                label: 'Match Time',
                readonly: true,
                controller: _matchTimeController,
                hintText: timeo.toString(),
                ontap: () {
                  selectTime(context);
                }),
            const SizedBox(
              height: 5,
            ),
            TextFormField1(
                label: 'Match Place', controller: _matchPlaceController),
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
                icon: Icon(Icons.alarm),
                label: Text('Schedule Match'),
                onPressed: () {
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
        _date = DateFormat('dd-MM-yyyy').format(_datePicker);
        ;
      });
      print(_date.toString());
    }
  }

  void selectTime(BuildContext context) async {
    String AM_PM = '';
    picked = (await showTimePicker(context: context, initialTime: time))!;

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
}
