import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fliersclub/screens/Admin_Screens/admin_dashboard_screen.dart';
import 'package:fliersclub/screens/AuthScreen/landing_screen.dart';
import 'package:fliersclub/screens/ClubScreens/tournament_screen1.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: LandingScreen());
  }

  // Future<String> roleCheck(String uid) async {
  //   String role = 'error on role check';
  //   try {
  //     firestore.doc(uid).get().then((value) {
  //       print(value.data()!['role'].toString());
  //     });
  //   } catch (e) {}
  //   return role;
  // }
}
