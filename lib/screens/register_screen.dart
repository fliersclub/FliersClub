import 'package:fliersclub/screens/clubuser_homescreen.dart';
import 'package:fliersclub/screens/tournment_screen.dart';
import 'package:fliersclub/widgets/textformfield.dart';
import 'package:fliersclub/widgets/welcome_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logo',
            child: Container(
              child: Image.asset('assets/whitefly.png'),
              height: 200,
            ),
          ),
          TextFormField1(hintText: 'Club Name'),
          const SizedBox(
            height: 15,
          ),
          TextFormField1(hintText: 'Club Register Number'),
          const SizedBox(
            height: 15,
          ),
          TextFormField1(hintText: 'Club Address'),
          const SizedBox(
            height: 50,
          ),
          WelcomeButton(
              text: 'Register',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClubUserHomeScreen();
                }));
              },
              color: Colors.black)
        ],
      ),
    );
  }
}
