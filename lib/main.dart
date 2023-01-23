import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fliersclub/screens/Admin_Screens/admin_dashboard_screen.dart';
import 'package:fliersclub/screens/Admin_Screens/adminhome_screen.dart';
import 'package:fliersclub/screens/AuthScreen/landing_screen.dart';
import 'package:fliersclub/screens/ClubScreens/tournament_screen1.dart';
import 'package:fliersclub/screens/RefereeScreens/refereehome.dart';
import 'package:fliersclub/screens/User_Screens/user_home.dart';
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
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                checkUser(id: snapshot.data!.uid, context: context);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const LandingScreen();
          },
        ));
  }

  checkUser({required id, required BuildContext context}) async {
    DocumentSnapshot snapshot =
        await firestore.collection('roles').doc(id).get();
    String role = snapshot.get('role');
    print('role is' + role);
    if (role == 'ClubAdmin') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
        return TournamentScreen1();
      })));
    } else if (role == 'Referee') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
        return RefereeHome();
      })));
    } else if (role == 'SuperAdmin') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
        return AdminDashboard();
      })));
    } else if (role == 'User') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: ((context) {
            return UserHome();
          }),
        ),
      );
    } else {
      print('invalid user');
    }
  }
}
