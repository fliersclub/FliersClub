import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:intl/intl.dart';

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
  String chanceTime = '';
  String _selectedReason = '';
  String _selectedchance = '';
  String formattedTime = '';
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
  String displayTime = '';
  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer1.dispose();
    _stopWatchTimer2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  displayTime = StopWatchTimer.getDisplayTime(value!,
                      hours: _isHours,
                      hoursRightBreak: 'hr ',
                      minuteRightBreak: 'min ',
                      secondRightBreak: 'sec ');
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.blue[50],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Pigeon 1  ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      displayTime,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              iscancelled1 == true
                                  ? const SizedBox()
                                  : isEnd1 == false
                                      ? Row(
                                          children: [
                                            iscancelled1 == true
                                                ? const SizedBox()
                                                : SizedBox(
                                                    width: 100,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors.red),
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return StatefulBuilder(
                                                              builder: ((context,
                                                                  setState) {
                                                                return AlertDialog(
                                                                  title:
                                                                      const Text(
                                                                    'Reason for Cancel ?',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                  content: Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        RadioListTile(
                                                                            title: const Text(
                                                                                'Owner Cancel'),
                                                                            value:
                                                                                'Owner Cancel',
                                                                            groupValue:
                                                                                _selectedReason,
                                                                            onChanged:
                                                                                (value) {
                                                                              setState(() {
                                                                                _selectedReason = value.toString();
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title: const Text(
                                                                                'Bird Missing / Time out'),
                                                                            value:
                                                                                'Bird Missing / Time out',
                                                                            groupValue:
                                                                                _selectedReason,
                                                                            onChanged:
                                                                                (value) {
                                                                              setState(() {
                                                                                _selectedReason = value.toString();
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title: const Text(
                                                                                'Landed Out of Boundary'),
                                                                            value:
                                                                                'Landed Out of Boundary',
                                                                            groupValue:
                                                                                _selectedReason,
                                                                            onChanged:
                                                                                (value) {
                                                                              setState(() {
                                                                                _selectedReason = value.toString();
                                                                              });
                                                                            }),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                                              onPressed: () {
                                                                                cancel();
                                                                                setState(() {
                                                                                  pigeon1time = displayTime.substring(0, 16);
                                                                                  pigeon2time = displayTime.substring(0, 16);
                                                                                });
                                                                              },
                                                                              child: const Text('Cancel'),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 15,
                                                                            ),
                                                                            ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text('Close'),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ]),
                                                                );
                                                              }),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                  ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.blue),
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: ((context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                              'Alert !',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                            content: const Text(
                                                              'Do you want to end match ?',
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ),
                                                            actions: [
                                                              ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red),
                                                                  onPressed:
                                                                      () {
                                                                    _stopWatchTimer1
                                                                        .onExecute
                                                                        .add(StopWatchExecute
                                                                            .stop);
                                                                    setState(
                                                                        () {
                                                                      pigeon1time =
                                                                          displayTime.substring(
                                                                              0,
                                                                              16);

                                                                      isEnd1 =
                                                                          true;
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Yes',
                                                                  )),
                                                              ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .black),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'No'))
                                                            ],
                                                          );
                                                        }));
                                                  },
                                                  child: const Text('End')),
                                            )
                                          ],
                                        )
                                      : const SizedBox(),
                            ],
                          ),
                          iscancelled1 == true
                              ? Text(
                                  'cancelled at ' + pigeon1time,
                                  style: TextStyle(color: Colors.red),
                                )
                              : const SizedBox(),
                          isEnd1 == true
                              ? Text('Match Ended ! Pigeon 1 time is ' +
                                  pigeon1time)
                              : const SizedBox(),
                          ElevatedButton.icon(
                            label: const Text('Sighted'),
                            icon: const Icon(Icons.remove_red_eye),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              String formattedTime =
                                  DateFormat.jm().format(DateTime.now());
                              _firebaseFirestore
                                  .collection('LiveMatches')
                                  .doc(widget.matchdata['matchid'])
                                  .update({
                                'pigeon1sightedAt':
                                    FieldValue.arrayUnion([formattedTime])
                              });
                              print('click on sighted');
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue[50],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Pigeon 2  ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      displayTime,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              iscancelled2 == true
                                  ? const SizedBox()
                                  : isEnd2 == false
                                      ? Row(
                                          children: [
                                            iscancelled1 == true
                                                ? const SizedBox()
                                                : SizedBox(
                                                    width: 100,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors.red),
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return StatefulBuilder(
                                                                builder: ((context,
                                                                    setState) {
                                                                  return AlertDialog(
                                                                    title:
                                                                        const Text(
                                                                      'Reason for Cancel ?',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                    content: Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          RadioListTile(
                                                                              title: const Text('Owner Cancel'),
                                                                              value: 'Owner Cancel',
                                                                              groupValue: _selectedReason,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  _selectedReason = value.toString();
                                                                                });
                                                                              }),
                                                                          RadioListTile(
                                                                              title: const Text('Bird Missing / Time out'),
                                                                              value: 'Bird Missing / Time out',
                                                                              groupValue: _selectedReason,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  _selectedReason = value.toString();
                                                                                });
                                                                              }),
                                                                          RadioListTile(
                                                                              title: const Text('Landed Out of Boundary'),
                                                                              value: 'Landed Out of Boundary',
                                                                              groupValue: _selectedReason,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  _selectedReason = value.toString();
                                                                                });
                                                                              }),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                                                onPressed: () {
                                                                                  cancel();
                                                                                  setState(() {
                                                                                    pigeon1time = displayTime.substring(0, 16);
                                                                                    pigeon2time = displayTime.substring(0, 16);
                                                                                  });
                                                                                },
                                                                                child: const Text('Cancel'),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 15,
                                                                              ),
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: const Text('Close'),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ]),
                                                                  );
                                                                }),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: const Text(
                                                            'Cancel')),
                                                  ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: ((context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                            'Alert !',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          content: const Text(
                                                            'Do you want to end match ?',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          actions: [
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .red),
                                                                onPressed: () {
                                                                  _stopWatchTimer2
                                                                      .onExecute
                                                                      .add(StopWatchExecute
                                                                          .stop);
                                                                  setState(
                                                                    () {
                                                                      pigeon2time =
                                                                          displayTime.substring(
                                                                              0,
                                                                              16);

                                                                      isEnd2 =
                                                                          true;
                                                                    },
                                                                  );
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Yes',
                                                                )),
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .black),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'No'))
                                                          ],
                                                        );
                                                      }));
                                                },
                                                child: const Text('End'),
                                              ),
                                            )
                                          ],
                                        )
                                      : const SizedBox(),
                            ],
                          ),
                          iscancelled2 == true
                              ? Text(
                                  'Cancelled at ' + pigeon2time,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : const SizedBox(),
                          isEnd2 == true
                              ? Text('Match Ended ! Pigeon 2 time is ' +
                                  pigeon2time)
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton.icon(
                            label: const Text('Sighted'),
                            icon: const Icon(Icons.remove_red_eye),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              String formattedTime =
                                  DateFormat.jm().format(DateTime.now());
                              _firebaseFirestore
                                  .collection('LiveMatches')
                                  .doc(widget.matchdata['matchid'])
                                  .update({
                                'Pigeon2sightedAt':
                                    FieldValue.arrayUnion([formattedTime])
                              });
                              print('click on sighted');
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 50,
            ),
            isStart == false
                ? SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          setState(() {
                            scope = false;
                          });
                          setState(() {
                            isStart = true;
                          });
                          _stopWatchTimer1.onExecute
                              .add(StopWatchExecute.start);
                          _stopWatchTimer2.onExecute
                              .add(StopWatchExecute.start);
                          String formattedTime =
                              DateFormat.jm().format(DateTime.now());
                          print(formattedTime);
                          launchlive(matchstarttime: formattedTime);
                        },
                        child: const Text(
                          'START',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
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
                      try {
                        await _firebaseFirestore
                            .collection('LiveMatches')
                            .doc(widget.matchdata['matchid'])
                            .update({'isLive': false});
                      } catch (e) {
                        print(e.toString());
                      }
                      endupdate(
                          chance: _selectedchance,
                          cancelreason: _selectedReason);

                      Navigator.of(context).pop();
                    },
                    child: const Text('End Match'),
                  ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow),
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
                                              _selectedchance =
                                                  value.toString();
                                            });
                                          }),
                                      RadioListTile(
                                          title: const Text('Falcon Attack'),
                                          value: 'Falcon Attack',
                                          groupValue: _selectedchance,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedchance =
                                                  value.toString();
                                            });
                                          }),
                                      RadioListTile(
                                          title: const Text('Night LightOut'),
                                          value: 'Night LightOut',
                                          groupValue: _selectedchance,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedchance =
                                                  value.toString();
                                            });
                                          }),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        onPressed: () async {
                                          print(_selectedchance);
                                          print(displayTime);
                                          endupdate(
                                              chancetime: displayTime,
                                              chance: _selectedchance,
                                              cancelreason: _selectedReason);

                                          try {
                                            await _firebaseFirestore
                                                .collection('LiveMatches')
                                                .doc(
                                                    widget.matchdata['matchid'])
                                                .update({'isLive': false});
                                          } catch (e) {
                                            print(e.toString());
                                          }
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
                      style: TextStyle(color: Colors.black, fontSize: 19),
                      'CHANCES',
                    )),
              ),
            )

            //
          ]),
        ),
      ),
    );
  }

  void endupdate(
      {required String chance,
      required String cancelreason,
      String? chancetime}) async {
    try {
      await _firebaseFirestore
          .collection('ScoreBoard')
          .doc(widget.matchdata['matchid'])
          .set({
        'chanceTime': chancetime,
        'matchid': widget.matchdata['matchid'],
        'chance': chance,
        'cancelreason': cancelreason,
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
          .update({
        'matchend': true,
        'chance': chance,
        'cancelled': iscancelled1,
        'cancelreason': cancelreason,
        'chanceTime': chancetime
      });

      await _firebaseFirestore
          .collection('ClubAdmin')
          .doc(widget.matchdata['cid'])
          .collection('tournaments')
          .doc(widget.matchdata['tournamentid'])
          .collection('matches')
          .doc(widget.matchdata['matchid'])
          .update({
        'matchend': true,
        'chance': chance,
        'cancelreason': cancelreason,
        'cancelled': iscancelled1,
        'chanceTime': chancetime
      });
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

  void launchlive({required String matchstarttime}) async {
    try {
      await _firebaseFirestore
          .collection('LiveMatches')
          .doc(widget.matchdata['matchid'])
          .set({
        'matchstarttime': matchstarttime,
        'matchendtime': '',
        'isLive': true
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
