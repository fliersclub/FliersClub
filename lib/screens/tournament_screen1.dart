import 'package:fliersclub/screens/tournment_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TournamentScreen1 extends StatefulWidget {
  const TournamentScreen1({super.key});

  @override
  State<TournamentScreen1> createState() => _TournamentScreen1State();
}

class _TournamentScreen1State extends State<TournamentScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          height: 80,
          child: Card(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tornament1 Name '),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return TournamentScreen2();
                    }));
                  },
                  child: Text('View Tournament'))
            ],
          )),
        ),
        Container(
          height: 80,
          child: Card(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tornament2 Name '),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {},
                  child: Text('View Tournament'))
            ],
          )),
        ),
        Container(
          height: 80,
          child: Card(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tornament3 Name '),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {},
                  child: Text('View Tournament'))
            ],
          )),
        ),
        Container(
          height: 80,
          child: Card(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tornament4 Name '),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {},
                  child: Text('View Tournament'))
            ],
          )),
        )
      ]),
    );
  }
}
