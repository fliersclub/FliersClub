import 'package:flutter/material.dart';

import 'dart:async';

class TournamentDetailPage extends StatefulWidget {
  const TournamentDetailPage({super.key});

  @override
  State<TournamentDetailPage> createState() => _TournamentDetailPageState();
}

class _TournamentDetailPageState extends State<TournamentDetailPage> {
  int clubname1visiblepoints = 0;
  int clubname1invisiblepoints = 0;
  late Timer myTimer;
  int matchend = 0;
  bool ismatchend = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myTimer.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      showDialog(
          context: context,
          builder: (contxet) {
            return AlertDialog(
              title: Text('Alert 15 in mintues!'),
              content: Text('Pigeon Visible?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    setState(() {
                      clubname1visiblepoints++;
                    });
                    Navigator.pop(context);
                  },
                  child: Text('visible'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    clubname1invisiblepoints++;
                    Navigator.pop(context);
                  },
                  child: Text('Not Visible'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                    timer.cancel();
                    setState(() {
                      ismatchend = true;
                    });
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
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        title: Text('Alert!'),
                        content: Text('Do you want to exit the match ?'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop(true);
                              },
                              child: Text('Yes')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No'))
                        ],
                      );
                    }));
              },
              child: Icon(Icons.exit_to_app))
        ],
        backgroundColor: Colors.black,
        title: Text('Clubname vs clubname'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          final value = false;
          if (value != null) {
            return Future.value(value);
          } else {
            return Future.value(false);
          }
        },
        child: Center(
            child: Column(children: <Widget>[
          // Text(time),
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
                  Column(children: [Text(clubname1visiblepoints.toString())]),
                ]),
                TableRow(children: [
                  Column(children: [Text('clubname2')]),
                  Column(children: [Text('0')]),
                ]),
              ],
            ),
          ),
          ismatchend == true
              ? Column(
                  children: [
                    Text(
                        'ClubName1 Match Ended with visibility point $clubname1visiblepoints'),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Go back'))
                  ],
                )
              : Text(''),
        ])),
      ),
    );
  }
}
