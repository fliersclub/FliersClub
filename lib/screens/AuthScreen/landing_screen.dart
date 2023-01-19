import 'package:fliersclub/screens/AuthScreen/allregister_screen.dart';
import 'package:fliersclub/screens/AuthScreen/login_screen.dart';
import 'package:fliersclub/screens/AuthScreen/register_screen.dart';
import 'package:fliersclub/screens/RefereeScreens/refree_reg_screen.dart';
import 'package:fliersclub/widgets/welcome_button.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  Animation? animation;
  AnimationController? controller;
  @override
  void dispose() {
    // TODO: implement dispose

    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller!, curve: Curves.decelerate);
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(children: [
          Flexible(
            child: Hero(
              tag: 'logo',
              child: Container(
                height: animation!.value * 100,
                child: Image(image: AssetImage('assets/whitefly.png')),
              ),
            ),
          ),
          const Text(
            'Flier\'s club',
            style: TextStyle(fontSize: 29),
          )
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: WelcomeButton(
              text: 'Login',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }));
              },
              color: Colors.black),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: WelcomeButton(
              text: 'Register',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AllRegisterScreen();
                }));
              },
              color: Colors.black),
        ),
      ]),
    );
  }
}
