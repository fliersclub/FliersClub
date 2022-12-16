import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fliersclub/screens/Admin_Screens/add_screen.dart';
import 'package:fliersclub/screens/Admin_Screens/adminhome_screen.dart';
import 'package:fliersclub/screens/Admin_Screens/approved_screen.dart';
import 'package:fliersclub/screens/Admin_Screens/pending_screen.dart';
import 'package:fliersclub/screens/landing_screen.dart';
import 'package:fliersclub/screens/usersettings_screen.dart';
import 'package:fliersclub/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  List _pages = [AdminHome(), SettingScreen(), AddScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          Container(
              color: Colors.black,
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Super Admin',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          const ListTile(
            title:
                Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Divider(),
          ListTile(
            title: Text('ClubUser Management',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Divider(),
        ],
      )),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LandingScreen()),
                    (Route<dynamic> route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
        title: Text('Super Admin'),
        backgroundColor: Colors.black,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'settings'),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.ad_units_rounded,
              ),
              label: 'add',
            )
          ]),
    );
  }
}