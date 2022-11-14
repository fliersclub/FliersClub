import 'package:fliersclub/widgets/textformfield.dart';
import 'package:fliersclub/widgets/welcome_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          TextFormField1(hintText: 'Username'),
          const SizedBox(
            height: 15,
          ),
          TextFormField1(hintText: 'Password'),
          const SizedBox(
            height: 50,
          ),
          WelcomeButton(text: 'Login', onPressed: () {}, color: Colors.black)
        ],
      ),
    );
  }
}
