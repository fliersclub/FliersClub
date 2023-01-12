import 'package:fliersclub/screens/AuthScreen/login_screen.dart';
import 'package:fliersclub/screens/AuthScreen/register_screen.dart';
import 'package:fliersclub/screens/RefereeScreens/refree_reg_screen.dart';
import 'package:fliersclub/widgets/welcome_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: WelcomeButton(
                    text: 'Club Register',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const RegisterScreen();
                      }));
                    },
                    color: Colors.black),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: WelcomeButton(
                    text: 'Refree Register',
                    onPressed: () {
                      print('navigate to umpire reg page');
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return RefereeRegScreen();
                      })));
                    },
                    color: Colors.black),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
