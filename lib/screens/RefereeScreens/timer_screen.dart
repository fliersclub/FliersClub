import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final StopWatchTimer _stopWatchTimer1 = StopWatchTimer();
  final StopWatchTimer _stopWatchTimer2 = StopWatchTimer();
  bool iscancelled1 = false;
  bool isEnd1 = false;
  bool isEnd2 = false;
  bool iscancelled2 = false;
  final _isHours = true;
  String pigeon1time = '';
  String pigeon2time = '';
  bool isStart = false;
  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Pigeon Timer'),
      ),
      body: Center(
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
                              ? SizedBox()
                              : isEnd1 == false
                                  ? Row(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              _stopWatchTimer1.onExecute
                                                  .add(StopWatchExecute.stop);

                                              setState(() {
                                                pigeon1time = displayTime
                                                    .substring(0, 16);

                                                iscancelled1 = true;
                                              });
                                            },
                                            child: Text('Cancel')),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              _stopWatchTimer1.onExecute
                                                  .add(StopWatchExecute.stop);
                                              setState(() {
                                                pigeon1time = displayTime
                                                    .substring(0, 16);
                                                isEnd1 = true;
                                              });
                                            },
                                            child: Text('End'))
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
                              ? SizedBox()
                              : isEnd2 == false
                                  ? Row(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              _stopWatchTimer2.onExecute
                                                  .add(StopWatchExecute.stop);
                                              print(pigeon2time);
                                              setState(() {
                                                pigeon2time = displayTime
                                                    .substring(0, 16);
                                                iscancelled2 = true;
                                              });
                                            },
                                            child: const Text('Cancel')),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            _stopWatchTimer2.onExecute
                                                .add(StopWatchExecute.stop);
                                            setState(() {
                                              pigeon2time =
                                                  displayTime.substring(0, 16);

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
                  onPressed: () {
                    setState(() {
                      isStart = true;
                    });
                    _stopWatchTimer1.onExecute.add(StopWatchExecute.start);
                    _stopWatchTimer2.onExecute.add(StopWatchExecute.start);
                  },
                  child: const Text('START'),
                )
              : ElevatedButton(onPressed: () {}, child: const Text('End Match'))
        ]),
      ),
    );
  }
}
