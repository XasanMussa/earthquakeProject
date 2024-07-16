import 'package:earthquake_app/Frondend/HomePage.dart';
import 'package:earthquake_app/Frondend/Users/SignIn.dart';
import 'package:earthquake_app/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickalert/quickalert.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isHidden = true;

  clearFields() {
    _fullNameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade900,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(200)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  width: 50,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200),
                      bottomLeft: Radius.circular(200),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 412,
            height: 543,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                  topRight: Radius.circular(80),
                )),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      hintText: "Enter Full Name",
                      hintStyle: TextStyle(
                          fontSize: 19, color: Colors.indigo.shade900),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.indigo.shade900,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo.shade900),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.indigo.shade900, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Enter E-mail",
                      hintStyle: TextStyle(
                          fontSize: 19, color: Colors.indigo.shade900),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.indigo.shade900,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo.shade900),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.indigo.shade900, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: isHidden,
                    decoration: InputDecoration(
                      hintText: "********",
                      hintStyle: TextStyle(
                          fontSize: 19, color: Colors.indigo.shade900),
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.indigo.shade900,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },
                        icon: Icon(
                          isHidden ? Icons.visibility_off : Icons.visibility,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo.shade900),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.indigo.shade900, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                GestureDetector(
                  onTap: () async {
                    String fullName = _fullNameController.text.trim();
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();

                    if (fullName.isNotEmpty &&
                        email.isNotEmpty &&
                        password.isNotEmpty) {
                      String result =
                          await registerUser(fullName, email, password);
                      if (result == "Success") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: result,
                        );
                      }
                    } else {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        text: "Please fill all fields",
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                        child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "have an account? ",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.indigo.shade900,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: Text(
                            "Back ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Future<String> registerUser(
      String fullName, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'fullName': fullName,
          'email': email,
        });
        return "Success";
      }
      return "User registration failed";
    } catch (e) {
      return e.toString();
    }
  }
}
