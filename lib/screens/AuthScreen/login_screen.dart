import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fliersclub/screens/Admin_Screens/admin_dashboard_screen.dart';
import 'package:fliersclub/screens/ClubScreens/tournament_screen1.dart';
import 'package:fliersclub/screens/RefereeScreens/refereehome.dart';
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
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedRole = 'Please choose a User';
  List<String> _roles = [
    'Please choose a User',
    'SuperAdmin',
    'ClubAdmin',
    'Referee'
  ];
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlueAccent),
              borderRadius: const BorderRadius.all(
                Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    elevation: 0,
                    isExpanded: true,
                    alignment: Alignment.center,
                    value: _selectedRole,
                    items: _roles.map((String role) {
                      return DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value.toString();
                        print('selected user is :' + value.toString());
                      });
                    }),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField1(controller: _emailController, hintText: 'Email'),
          const SizedBox(
            height: 15,
          ),
          TextFormField1(controller: _passwordController, hintText: 'Password'),
          const SizedBox(
            height: 50,
          ),
          isLoading == true
              ? Center(child: CircularProgressIndicator())
              : WelcomeButton(
                  text: 'Login',
                  onPressed: () async {
                    print(_selectedRole);
                    setState(() {
                      isLoading = true;
                    });
                    String res = await AuthMethod().login(
                        email: _emailController.text,
                        password: _passwordController.text,
                        role: _selectedRole);
                    if (res == 'SuperAdmin') {
                      //Navigating to admin panel
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AdminDashboard();
                        }),
                      );
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
                  },
                  color: Colors.black)
        ],
      ),
    );
  }
}
