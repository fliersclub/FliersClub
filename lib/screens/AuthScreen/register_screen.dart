import 'dart:typed_data';

import 'package:fliersclub/services/auth_methods.dart';
import 'package:fliersclub/widgets/textformfield.dart';
import 'package:fliersclub/widgets/welcome_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Uint8List? File;
  bool isLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _clubNameController = TextEditingController();
  TextEditingController _clubaddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    _clubNameController.dispose();
    _clubaddressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    selectImage(ImageSource.gallery);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: File == null
                        ? AssetImage('assets/image.png') as ImageProvider
                        : MemoryImage(File!),
                    radius: 75,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField1(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email';
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: _emailController,
                    hintText: 'Email'),
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
                  height: 15,
                ),
                TextFormField1(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an mobile number';
                      } else if (value.length > 10) {
                        return 'Please enter a valid mobile number';
                      }
                      return null;
                    },
                    controller: _mobileController,
                    hintText: 'mobile'),
                const SizedBox(
                  height: 15,
                ),
                TextFormField1(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an Club Name';
                      }
                      return null;
                    },
                    controller: _clubNameController,
                    hintText: 'Club Name'),
                const SizedBox(
                  height: 15,
                ),
                TextFormField1(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an Club Address';
                      }
                      return null;
                    },
                    controller: _clubaddressController,
                    hintText: 'Club Address'),
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
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            String res = await AuthMethod().register(
                                file: File,
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(res.toString()),
                                backgroundColor: Colors.red,
                              ));
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
        ),
      ),
    );
  }

  void selectImage(ImageSource source) async {
    Uint8List im = await pickImage(source);
    setState(() {
      File = im;
    });
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text('No image selected'),
      ),
    );
    Navigator.pop(context);
    print('No image selected');
  }
}
