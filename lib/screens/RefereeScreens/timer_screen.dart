import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerScreen extends StatefulWidget {
  var matchdata;
  TimerScreen({this.matchdata});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.matchdata);
  }

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String _selectedchance = '';

  final StopWatchTimer _stopWatchTimer1 = StopWatchTimer();
  final StopWatchTimer _stopWatchTimer2 = StopWatchTimer();
  bool scope = true;
  bool iscancelled1 = false;
  bool isEnd1 = false;
  bool isEnd2 = false;
  bool iscancelled2 = false;
  final _isHours = true;
  String pigeon1time = '';
  String pigeon2time = '';
  String winnerPigeon = '';
  String winnertime = '';
  bool isStart = false;
  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer1.dispose();
    _stopWatchTimer2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Pigeon Timer'),
      ),
      body: WillPopScope(
        onWillPop: () async => scope,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            StreamBuilder<int>(
                stream: _stopWatchTimer1.rawTime,
                initialData: _stopWatchTimer1.rawTime.value,
                builder: (context, snapshot) {
                  final value = snapshot.data;
                  final displayTime = StopWatchTimer.getDisplayTime(value!,
                      hours: _isHours,
                      hoursRightBreak: 'hr ',
                      minuteRightBreak: 'min ',
                      secondRightBreak: 'sec ');
                  return Container(
                    height: 150,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Pigeon 1 : ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              displayTime,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            iscancelled1 == true
                                ? const SizedBox()
                                : isEnd1 == false
                                    ? Row(
                                        children: [
                                          iscancelled1 == true
                                              ? const SizedBox()
                                              : ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.blueGrey),
                                                  onPressed: () {
                                                    cancel();
                                                    setState(() {
                                                      pigeon1time = displayTime
                                                          .substring(0, 16);
                                                      pigeon2time = displayTime
                                                          .substring(0, 16);
                                                    });
                                                  },
                                                  child: const Text('Cancel')),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.blueGrey),
                                              onPressed: () {
                                                _stopWatchTimer1.onExecute
                                                    .add(StopWatchExecute.stop);
                                                setState(() {
                                                  pigeon1time = displayTime
                                                      .substring(0, 16);

                                                  isEnd1 = true;
                                                });
                                              },
                                              child: const Text('End'))
                                        ],
                                      )
                                    : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        iscancelled1 == true
                            ? Text(
                                'cancelled at ' + pigeon1time,
                                style: TextStyle(color: Colors.red),
                              )
                            : SizedBox(),
                        isEnd1 == true
                            ? Text(
                                'Match Ended ! Pigeon 1 time is ' + pigeon1time)
                            : const SizedBox(),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  );
                }),
            StreamBuilder<int>(
                stream: _stopWatchTimer2.rawTime,
                initialData: _stopWatchTimer2.rawTime.value,
                builder: (context, snapshot) {
                  final value = snapshot.data;
                  final displayTime = StopWatchTimer.getDisplayTime(value!,
                      hours: _isHours,
                      hoursRightBreak: 'hr ',
                      minuteRightBreak: 'min ',
                      secondRightBreak: 'sec ');
                  return Container(
                    height: 150,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Pigeon 2 : ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              displayTime,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            iscancelled2 == true
                                ? const SizedBox()
                                : isEnd2 == false
                                    ? Row(
                                        children: [
                                          iscancelled1 == true
                                              ? SizedBox()
                                              : ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.blueGrey),
                                                  onPressed: () {
                                                    cancel();
                                                    setState(() {
                                                      pigeon1time = displayTime
                                                          .substring(0, 16);
                                                      pigeon2time = displayTime
                                                          .substring(0, 16);
                                                    });
                                                  },
                                                  child: Text('Cancel')),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blueGrey),
                                            onPressed: () {
                                              _stopWatchTimer2.onExecute
                                                  .add(StopWatchExecute.stop);
                                              setState(() {
                                                pigeon2time = displayTime
                                                    .substring(0, 16);

                                                isEnd2 = true;
                                              });
                                            },
                                            child: const Text('End'),
                                          )
                                        ],
                                      )
                                    : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        iscancelled2 == true
                            ? Text(
                                'Cancelled at ' + pigeon2time,
                                style: TextStyle(color: Colors.red),
                              )
                            : const SizedBox(),
                        isEnd2 == true
                            ? Text(
                                'Match Ended ! Pigeon 2 time is ' + pigeon2time)
                            : const SizedBox(),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  );
                }),
            isStart == false
                ? ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      setState(() {
                        scope = false;
                      });
                      setState(() {
                        isStart = true;
                      });
                      _stopWatchTimer1.onExecute.add(StopWatchExecute.start);
                      _stopWatchTimer2.onExecute.add(StopWatchExecute.start);
                    },
                    child: const Text('START'),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      int result = pigeon1time.compareTo(pigeon2time);

                      if (result < 0) {
                        setState(() {
                          winnerPigeon = 'pigeon2';
                          winnertime = pigeon2time;
                        });
                        print('pigeon 2 is greater');
                      } else if (result > 0) {
                        setState(() {
                          winnerPigeon = 'pigeon1';
                          winnertime = pigeon1time;
                        });
                        print('pigeon 1 is greater');
                      } else {
                        setState(() {
                          winnerPigeon = 'Equal';
                          winnertime = pigeon1time;
                        });
                        print('pigeon 1 and pigeon 2 are equal time');
                      }

                      print(widget.matchdata['matchid']);

                      endupdate(chance: _selectedchance);

                      Navigator.of(context).pop();
                    },
                    child: const Text('End Match'),
                  ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: const Text('Select a Reason'),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile(
                                      title: const Text('Rain'),
                                      value: 'Rain',
                                      groupValue: _selectedchance,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedchance = value.toString();
                                        });
                                      }),
                                  RadioListTile(
                                      title: const Text('Falcon Attack'),
                                      value: 'Falcon Attack',
                                      groupValue: _selectedchance,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedchance = value.toString();
                                        });
                                      }),
                                  RadioListTile(
                                      title: const Text('Night LightOut'),
                                      value: 'Night LightOut',
                                      groupValue: _selectedchance,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedchance = value.toString();
                                        });
                                      }),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    onPressed: () {
                                      print(_selectedchance);
                                      endupdate(chance: _selectedchance);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'End',
                                    ),
                                  )
                                ]),
                          );
                        },
                      );
                    },
                  );
                },
                child: const Text(
                  style: TextStyle(color: Colors.black),
                  'Chances',
                ))

            //
          ]),
        ),
      ),
    );
  }

  void endupdate({required String chance}) async {
    try {
      await _firebaseFirestore
          .collection('ScoreBoard')
          .doc(widget.matchdata['matchid'])
          .set({
        'matchid': widget.matchdata['matchid'],
        'chance': chance,
        'cancelled': iscancelled1,
        'participantName': widget.matchdata['participantName'],
        'mobile': widget.matchdata['mobile'],
        'matchtime': widget.matchdata['matchtime'],
        'matchplace': widget.matchdata['matchplace'],
        'matchdate': widget.matchdata['matchdate'],
        'matchumpire': widget.matchdata['matchumpire'],
        'tournamentName': widget.matchdata['tournamentName'],
        'tournamentid': widget.matchdata['tournamentid'],
        'winnerPigeon': winnerPigeon,
        'pigeon1time': pigeon1time,
        'pigeon2time': pigeon2time,
        'winnertime': winnertime,
      });

      await _firebaseFirestore
          .collection('Referee')
          .doc(
            widget.matchdata['matchumpire'],
          )
          .collection('Matches')
          .doc(widget.matchdata['matchid'])
          .update(
              {'matchend': true, 'chance': chance, 'cancelled': iscancelled1});

      await _firebaseFirestore
          .collection('ClubAdmin')
          .doc(widget.matchdata['cid'])
          .collection('tournaments')
          .doc(widget.matchdata['tournamentid'])
          .collection('matches')
          .doc(widget.matchdata['matchid'])
          .update(
              {'matchend': true, 'chance': chance, 'cancelled': iscancelled1});
    } catch (e) {
      print(e.toString());
    }
  }

  void cancel() {
    _stopWatchTimer1.onExecute.add(StopWatchExecute.stop);
    _stopWatchTimer2.onExecute.add(StopWatchExecute.stop);
    setState(() {
      iscancelled1 = true;
      iscancelled2 = true;
    });
  }
}
