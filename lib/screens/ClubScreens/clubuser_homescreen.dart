import 'package:fliersclub/screens/ClubScreens/tournament_screen1.dart';
import 'package:fliersclub/screens/ClubScreens/userprofile_screen.dart';
import 'package:fliersclub/screens/ClubScreens/usersettings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClubUserHomeScreen extends StatefulWidget {
  @override
  State<ClubUserHomeScreen> createState() => _ClubUserHomeScreenState();
}

class _ClubUserHomeScreenState extends State<ClubUserHomeScreen> {
  List pages = [TournamentScreen1(), UserProfileScreen(), SettingScreen()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 5),
        child: FloatingActionButton(
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: const Text('Do you want to add tournament ?'),
                      title: const Text('Alert!'),
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
        title: const Text('Fliers Club'),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const [
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
