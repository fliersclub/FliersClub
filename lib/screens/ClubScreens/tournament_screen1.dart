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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: 70,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'ClubAdmin',
                style: TextStyle(fontSize: 20),
              ),
              Divider(
                color: Colors.black,
                height: 5,
              ),
              ListTile(
                title: Text('Profile'),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                onTap: (() {
                  _auth.signOut();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: ((context) {
                    return LandingScreen();
                  })), (route) => false);
                }),
                title: Text(
                  'Log Out',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('ClubAdmin'),
          actions: [
            IconButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: ((context) {
                    return const LandingScreen();
                  })), (route) => false);
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: const ClubAdminHome());
  }
}
