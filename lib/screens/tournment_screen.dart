import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TournamentScreen extends StatelessWidget {
  const TournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Text(
            'Tournaments',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Container(
          height: 100,
          width: double.infinity,
          child: Card(
              child: Center(
                  child: Text(
            'Clubname vs clubname',
            style: TextStyle(fontWeight: FontWeight.bold),
          ))),
        ),
        Container(
          height: 100,
          width: double.infinity,
          child: Card(
              child: Center(
                  child: Text(
            'Clubname vs clubname',
            style: TextStyle(fontWeight: FontWeight.bold),
          ))),
        ),
        Container(
          height: 100,
          width: double.infinity,
          child: Card(
              child: Center(
                  child: Text(
            'Clubname vs clubname',
            style: TextStyle(fontWeight: FontWeight.bold),
          ))),
        )
      ]),
    );
  }
}
