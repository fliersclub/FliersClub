import 'package:fliersclub/screens/timer_screen.dart';
import 'package:fliersclub/screens/tournamentdetail_screen.dart';
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
      body: Column(
        children: [
          Expanded(
            child: ListView(shrinkWrap: true, children: [
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
              tournament(context),
              const SizedBox(
                height: 5,
              ),
            ]),
          ),
          Container(
            height: 50,
            width: double.infinity,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 35,
                width: 150,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('UMPIRE'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 35,
                width: 150,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Tournament'),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  Container tournament(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Card(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Tornament1 Name '),
          ),
          const Divider(),
          Text('No.Of Registered Participants : 5'),
          Text('Match Date: 26-11-2022'),
          Text('Status: Pending'),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TournamentScreen2();
                }));
              },
              child: Text('View Tournament')),
          const SizedBox(
            height: 5,
          ),
        ],
      )),
    );
  }
}
