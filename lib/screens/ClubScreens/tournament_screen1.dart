import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fliersclub/models/clubuser.dart';
import 'package:fliersclub/screens/AuthScreen/landing_screen.dart';
import 'package:fliersclub/screens/ClubScreens/add_tournament_screen.dart';
import 'package:fliersclub/screens/ClubScreens/clubadmin_home.dart';
import 'package:fliersclub/screens/ClubScreens/tournment_screen2.dart';
import 'package:flutter/material.dart';

class TournamentScreen1 extends StatefulWidget {
  const TournamentScreen1({super.key});

  @override
  State<TournamentScreen1> createState() => _TournamentScreen1State();
}

class _TournamentScreen1State extends State<TournamentScreen1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('ClubAdmin'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: ((context) {
                    return LandingScreen();
                  })), (route) => false);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: ClubAdminHome());
  }
}
