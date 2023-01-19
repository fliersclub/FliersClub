import 'package:fliersclub/screens/AuthScreen/register_screen.dart';
import 'package:fliersclub/screens/RefereeScreens/refree_reg_screen.dart';
import 'package:fliersclub/screens/User_Screens/user_reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widgets/welcome_button.dart';

class AllRegisterScreen extends StatelessWidget {
  const AllRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: WelcomeButton(
              text: 'Club Register',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RegisterScreen();
                }));
              },
              color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: WelcomeButton(
              text: 'Refree Register',
              onPressed: () {
                print('navigate to umpire reg page');
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return RefereeRegScreen();
                })));
              },
              color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: WelcomeButton(
              text: 'User Register',
              onPressed: () {
                print('navigate to umpire reg page');
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return const UserRegistration();
                })));
              },
              color: Colors.black),
        ),
      ]),
    );
  }
}
