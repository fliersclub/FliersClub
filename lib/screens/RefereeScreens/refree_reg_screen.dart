import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fliersclub/models/referee.dart';
import 'package:fliersclub/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class RefereeRegScreen extends StatefulWidget {
  const RefereeRegScreen({super.key});

  @override
  State<RefereeRegScreen> createState() => _RefereeRegScreenState();
}

class _RefereeRegScreenState extends State<RefereeRegScreen> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Uint8List? File;
  bool isLoading = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchClubs();
  }

  final List<String> _selectedClubs = [];
  final List<String> _selectedClubsName = [];
  final List<Map<String, dynamic>> clubs = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Referee Registration'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: File == null
                      ? const AssetImage('assets/nouser.png')
                      : MemoryImage(File!) as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Choose image from'),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(),
                                    onPressed: () {
                                      selectImage(ImageSource.camera);
                                    },
                                    child: const Text('camera'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      selectImage(ImageSource.gallery);
                                    },
                                    child: const Text('Gallery'),
                                  ),
                                ],
                              ));
                    },
                    icon: const Icon(Icons.camera_alt),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField1(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Name';
                }
                return null;
              },
              controller: _nameController,
              hintText: 'Name',
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField1(
              type: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an email';
                } else if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              controller: _emailController,
              hintText: 'Email',
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField1(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an password';
                } else if (value.length < 6) {
                  return 'Password is weak';
                }
                return null;
              },
              controller: _passwordController,
              hintText: 'Password',
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField1(
              type: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an number';
                } else if (value.length > 10 || value.length < 10) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              controller: _mobileController,
              hintText: 'Mobile',
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField1(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an address';
                }
                return null;
              },
              controller: _addressController,
              hintText: 'address',
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: ((context) {
                    return StatefulBuilder(
                      builder: ((context, setState) {
                        return AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('cancel')),
                            TextButton(
                              onPressed: () {
                                refresh();
                                print(_selectedClubs);
                                Navigator.pop(context);
                              },
                              child: const Text('submit'),
                            )
                          ],
                          title: const Text('Select your interested Clubs'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: clubs
                                  .map(
                                    (club) => CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(club['name']),
                                      value: _selectedClubs.contains(
                                        club['id'].toString(),
                                      ),
                                      onChanged: ((isChecked) {
                                        setState(() {
                                          if (isChecked!) {
                                            _selectedClubs
                                                .add(club['id'].toString());
                                            _selectedClubsName
                                                .add(club['name']);
                                            print('added');
                                          } else {
                                            _selectedClubs
                                                .remove(club['id'].toString());
                                            _selectedClubsName
                                                .remove(club['name']);
                                            print('removed');
                                          }
                                        });
                                      }),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                height: 50,
                width: 250,
                child: const Card(
                  child: Center(
                    child: Text(
                      'Select Interested Clubs',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),
            Wrap(
                children: _selectedClubsName
                    .map(
                      (e) => Chip(
                        label: Text(e),
                      ),
                    )
                    .toList()),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  print('reg');
                  print(_selectedClubs);
                  print(_selectedClubsName);
                  String res = await registerReferee(
                      file: File,
                      email: _emailController.text,
                      password: _passwordController.text,
                      name: _nameController.text,
                      address: _addressController.text,
                      mobile: _mobileController.text,
                      selectedClubs: _selectedClubs);
                  if (res == 'success') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Success'),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(res),
                      ),
                    );
                  }
                  print(res);
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: const Text('Register'),
            )
          ]),
        ),
      ),
    );
  }

  void fetchClubs() async {
    String res = 'Some error occured while registration';
    try {
      CollectionReference clubcl = await _firestore.collection('ClubAdmin');
      clubcl.get().then(
            (value) => value.docs.forEach((element) {
              print(element.get('clubName'));
              String name = element.get('clubName');
              String id = element.get('id');
              clubs.add({'name': name, 'id': id});
            }),
          );
    } catch (e) {
      print(e.toString());
    }
  }

  void refresh() {
    setState(() {});
  }

  Future<String> registerReferee(
      {required String name,
      required String email,
      required String password,
      required file,
      required String mobile,
      required String address,
      required List selectedClubs}) async {
    String res = 'Error while registering referee';
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String photoUrl = await uploadImageToStorage(
          childName: 'RefereeprofilePics',
          file: file,
          isPost: false,
          id: cred.user!.uid);

      Referee referee = Referee(
          role: 'Referee',
          pic: photoUrl,
          email: email,
          password: password,
          id: cred.user!.uid,
          name: name,
          mobile: mobile,
          address: address,
          interestedclubs: selectedClubs,
          joinedClubs: []);
      res = 'success';
      await _firestore
          .collection('Referee')
          .doc(cred.user!.uid)
          .set(referee.toJson());
      await _firestore.collection('roles').doc(cred.user!.uid).set({
        'role': 'Referee',
      });
    } catch (e) {
      res = e.toString();
    }
    _nameController.clear();
    _addressController.clear();
    _mobileController.clear();
    _emailController.clear();
    _passwordController.clear();
    return res;
  }

  void selectImage(ImageSource source) async {
    Uint8List im = await pickImage(source);
    setState(() {
      File = im;
    });
    Navigator.pop(context);
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

  Future<String> uploadImageToStorage(
      {required String childName,
      required Uint8List file,
      required bool isPost,
      required id}) async {
    Reference ref = _firebaseStorage
        .ref()
        .child(childName)
        .child(_firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
