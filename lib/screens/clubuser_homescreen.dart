import 'package:fliersclub/screens/tournment_screen.dart';
import 'package:fliersclub/screens/userprofile_screen.dart';
import 'package:fliersclub/screens/usersettings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClubUserHomeScreen extends StatefulWidget {
  @override
  State<ClubUserHomeScreen> createState() => _ClubUserHomeScreenState();
}

class _ClubUserHomeScreenState extends State<ClubUserHomeScreen> {
  List pages = [TournamentScreen(), UserProfileScreen(), SettingScreen()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20, right: 5),
        child: FloatingActionButton(
            backgroundColor: Colors.black,
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Do you want to add tournament ?'),
                      actions: [
                        TextButton(
                          onPressed: () {},
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        )
                      ],
                    );
                  });
            }),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Fliers Club'),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.settings),
            )
          ]),
    );
  }
}
