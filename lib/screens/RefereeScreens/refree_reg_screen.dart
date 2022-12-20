import 'package:fliersclub/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RefereeRegScreen extends StatefulWidget {
  const RefereeRegScreen({super.key});

  @override
  State<RefereeRegScreen> createState() => _RefereeRegScreenState();
}

class _RefereeRegScreenState extends State<RefereeRegScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final List<String> _selectedClubs = [];
  final List<String> clubs = [
    'Club1',
    'Club2',
    'Club3',
    'Club4',
    'Club5',
    'Club6',
    'Club7',
    'Club8',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Referee Registration'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                                Navigator.pop(context);
                                submit();
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
                                    title: Text(club),
                                    value: _selectedClubs.contains(club),
                                    onChanged: ((isChecked) {
                                      setState(() {
                                        if (isChecked!) {
                                          _selectedClubs.add(club);
                                          print('added');
                                        } else {
                                          _selectedClubs.remove(club);
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
            children: _selectedClubs
                .map(
                  (e) => Chip(
                    onDeleted: () {
                      setState(() {
                        _selectedClubs.remove(e);
                      });
                    },
                    deleteIcon: Icon(Icons.cancel),
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
          },
          child: const Text('Register'),
        )
      ]),
    );
  }

  void submit() {
    setState(() {});
  }
}
