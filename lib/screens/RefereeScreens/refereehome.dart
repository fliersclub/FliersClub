import 'package:fliersclub/screens/RefereeScreens/timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RefereeHome extends StatefulWidget {
  const RefereeHome({super.key});

  @override
  State<RefereeHome> createState() => _RefereeHomeState();
}

class _RefereeHomeState extends State<RefereeHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Column(children: [
              Text('ClubName'),
              Text('Match date : 29-12-2022'),
              Text('Match time :10.00 am'),
              Text('Match place :ksd'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) {
                          return TimerScreen();
                        })));
                      },
                      child: Text('View')),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Reject')),
                ],
              )
            ]),
          )
        ]),
      ),
    );
  }
}
