import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fliersclub/screens/Admin_Screens/admin_dashboard_screen.dart';
import 'package:fliersclub/screens/ClubScreens/tournament_screen1.dart';
import 'package:fliersclub/screens/RefereeScreens/refereehome.dart';
import 'package:fliersclub/screens/User_Screens/user_home.dart';
import 'package:fliersclub/services/auth_methods.dart';
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
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedRole = 'Please choose a User';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('assets/whitefly.png'),
                height: 200,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField1(
              auto: [AutofillHints.email],
              controller: _emailController,
              hintText: 'Email',
              validator: ((value) {
                if (value!.isEmpty) {
                  return 'Please enter an email';
                } else if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              }),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField1(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an password';
                  } else if (value.length < 6) {
                    return 'Password is too weak';
                  }
                  return null;
                },
                controller: _passwordController,
                hintText: 'Password'),
            const SizedBox(
              height: 50,
            ),
            isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : WelcomeButton(
                    text: 'Login',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        String res = await AuthMethod().login(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        if (res == 'SuperAdmin') {
                          //Navigating to admin panel

                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return AdminDashboard();
                          }), (route) => false);
                        } else if (res == 'ClubAdmin') {
                          //Navigating to clubadmin panel
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return TournamentScreen1();
                              },
                            ),
                          );
                        } else if (res == 'Referee') {
                          //Navigating to referees panel
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RefereeHome();
                              },
                            ),
                          );
                        } else if (res == 'User') {
                          //Navigating to referees panel
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UserHome();
                              },
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(res),
                            backgroundColor: Colors.red,
                          ));
                          setState(() {
                            isLoading = false;
                          });
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    color: Colors.black)
          ],
        ),
      ),
    );
  }
}
