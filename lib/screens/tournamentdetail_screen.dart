import 'package:flutter/material.dart';

import 'dart:async';

class TournamentDetailPage extends StatefulWidget {
  const TournamentDetailPage({super.key});

  @override
  State<TournamentDetailPage> createState() => _TournamentDetailPageState();
}

class _TournamentDetailPageState extends State<TournamentDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer myTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      showDialog(
          context: context,
          builder: (contxet) {
            return AlertDialog(
              title: Text('Alert 5 sec!'),
              content: Text('Pigeon Visible?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('visible'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Not Visible'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                    timer.cancel();
                  },
                  child: Text('End Match'),
                )
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Clubname vs clubname'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          child: Table(
            defaultColumnWidth: FixedColumnWidth(120.0),
            border: TableBorder.all(
                color: Colors.black, style: BorderStyle.solid, width: 2),
            children: [
              TableRow(children: [
                Column(children: [
                  Text('Clubname', style: TextStyle(fontSize: 18.0))
                ]),
                Column(children: [
                  Text('visible', style: TextStyle(fontSize: 18.0))
                ]),
              ]),
              TableRow(children: [
                Column(children: [Text('clubname1')]),
                Column(children: [Text('0')]),
              ]),
              TableRow(children: [
                Column(children: [Text('clubname2')]),
                Column(children: [Text('0')]),
              ]),
            ],
          ),
        ),
      ])),
    );
  }
}
