import 'package:fliersclub/screens/User_Screens/user_home.dart';
import 'package:fliersclub/services/auth_methods.dart';
import 'package:fliersclub/widgets/textformfield.dart';
import 'package:fliersclub/widgets/welcome_button.dart';
import 'package:flutter/material.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  bool isLoading = false;
  AuthMethod _authMethod = AuthMethod();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('User Registration'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField1(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                  },
                  controller: _nameController,
                  hintText: 'Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField1(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                  },
                  controller: _emailController,
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField1(
                  type: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Monile';
                    } else if (value.length != 10) {
                      return 'Please enter a valid number';
                    }
                  },
                  controller: _mobileController,
                  hintText: 'Mobile',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField1(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    } else if (value.length < 6) {
                      return 'Password is weak';
                    }
                  },
                  controller: _passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField1(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter address';
                    }
                  },
                  controller: _addressController,
                  hintText: 'Address',
                ),
                const SizedBox(
                  height: 10,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : WelcomeButton(
                        text: 'Register',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            userReg(
                                mobile: _mobileController.text,
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                Address: _passwordController.text);
                          }
                        },
                        color: Colors.black)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void userReg({
    required String name,
    required String email,
    required String mobile,
    required String password,
    required String Address,
  }) async {
    setState(() {
      isLoading = true;
    });
    String res = await _authMethod.userRegister(
        email: email,
        name: name,
        password: password,
        mobile: mobile,
        address: Address);
    setState(() {
      isLoading = false;
    });
    if (res == 'success') {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return UserHome();
        },
      ), (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    }
  }
}
