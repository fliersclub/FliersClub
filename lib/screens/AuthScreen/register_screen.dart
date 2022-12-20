import 'package:fliersclub/services/auth_methods.dart';
import 'package:fliersclub/widgets/textformfield.dart';
import 'package:fliersclub/widgets/welcome_button.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _clubNameController = TextEditingController();
  TextEditingController _clubaddressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
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
              TextFormField1(controller: _emailController, hintText: 'Email'),
              const SizedBox(
                height: 15,
              ),
              TextFormField1(
                  controller: _passwordController, hintText: 'Password'),
              const SizedBox(
                height: 15,
              ),
              TextFormField1(controller: _mobileController, hintText: 'mobile'),
              const SizedBox(
                height: 15,
              ),
              TextFormField1(
                  controller: _clubNameController, hintText: 'Club Name'),
              const SizedBox(
                height: 15,
              ),
              TextFormField1(
                  controller: _clubaddressController, hintText: 'Club Address'),
              const SizedBox(
                height: 50,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : WelcomeButton(
                      text: 'Register',
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        String res = await AuthMethod().register(
                            isApproved: false,
                            email: _emailController.text,
                            password: _passwordController.text,
                            mobile: _mobileController.text,
                            clubName: _clubNameController.text,
                            address: _clubaddressController.text);
                        if (res == 'success') {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: Text(
                                    'Success',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  content: Text(
                                      'Club request is forwarded to admin for approval'),
                                  actions: [
                                    Center(
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK')),
                                    )
                                  ],
                                );
                              }));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(res.toString()),
                            backgroundColor: Colors.red,
                          ));
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      color: Colors.black)
            ],
          ),
        ),
      ),
    );
  }
}
