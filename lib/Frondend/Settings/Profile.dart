import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:earthquake_app/Frondend/HomePage.dart';
import 'package:earthquake_app/Frondend/Settings/EditProfile.dart';
import 'package:earthquake_app/Frondend/Settings/change.dart';
import 'package:earthquake_app/Frondend/Users/ChangePassword.dart';
import 'package:earthquake_app/Frondend/Users/SignIn.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  User? _user;
  String _fullName = '';
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    _user = _auth.currentUser;
    if (_user != null) {
      var userData = await _firestore.collection('users').doc(_user!.uid).get();
      setState(() {
        _fullName = userData.data()?['fullName'] ?? 'No Name';
        _profileImageUrl = userData.data()?['profileImageUrl'];
      });
    }
  }

  Future<void> _pickAndUploadImage() async {
    if (await Permission.storage.request().isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File file = File(pickedFile.path);
        try {
          // Upload to Firebase Storage
          String fileName = '${_user!.uid}/profile_picture.jpg';
          TaskSnapshot snapshot = await FirebaseStorage.instance
              .ref()
              .child(fileName)
              .putFile(file);
          String downloadUrl = await snapshot.ref.getDownloadURL();

          // Update Firestore with new profile image URL
          await _firestore.collection('users').doc(_user!.uid).update({
            'profileImageUrl': downloadUrl,
          });

          setState(() {
            _profileImageUrl = downloadUrl;
          });
        } catch (e) {
          print('Error uploading image: $e');
        }
      }
    } else {
      print('Storage permission not granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 25, right: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 140.0),
                  child: Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.of(context).push(
                //         MaterialPageRoute(builder: (context) => EditProfile()),
                //       );
                //     },
                //     child: Icon(
                //       Icons.person_pin,
                //       size: 30,
                //       color: Colors.white70,
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 120.0),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: _profileImageUrl != null
                        ? NetworkImage(_profileImageUrl!)
                        : AssetImage('images/profile.jpeg') as ImageProvider,
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                  Positioned(
                    top: 70,
                    left: 60,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: _pickAndUploadImage,
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 120.0),
              child: Text(
                _fullName,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: 15),

            // Padding(
            //   padding: const EdgeInsets.only(right: 20.0),
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (_) => EditProfile()));
            //     },
            //     child: Container(
            //       width: double.infinity,
            //       decoration: BoxDecoration(
            //           color: Colors.indigo,
            //           borderRadius: BorderRadius.all(Radius.circular(45))),
            //       margin: EdgeInsets.symmetric(horizontal: 20),
            //       padding: EdgeInsets.symmetric(vertical: 15),
            //       child: Center(
            //         child: Text(
            //           "Edit Profile",
            //           style: TextStyle(
            //               fontSize: 23,
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            SizedBox(height: 50),
            // ListTile(
            //   onTap: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => ChangePassword()),
            //     );
            //   },
            //   title: Text(
            //     'Change Password',
            //     style: TextStyle(
            //         fontSize: 22,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white),
            //   ),
            //   trailing: Icon(
            //     Icons.arrow_right,
            //     size: 30,
            //     color: Colors.white,
            //   ),
            // ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Do you want to Logout?',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'No',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _auth.signOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()),
                                (Route<dynamic> route) => false);
                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(
                                color: Colors.indigo.shade900, fontSize: 20),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              title: Text(
                'LogOut',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_right, size: 30, color: Colors.white),
            ),
          ]),
        ),
      ),
    );
  }
}
