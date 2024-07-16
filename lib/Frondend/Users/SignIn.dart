import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earthquake_app/Frondend/HomePage.dart';
import 'package:earthquake_app/Frondend/Users/ForgetPassword.dart';
import 'package:earthquake_app/Frondend/Users/SignUp.dart';
import 'package:earthquake_app/auth_service.dart';
import 'package:earthquake_app/database_service.dart';
import 'package:earthquake_app/helper/helper_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  void Login() {
    clearFields();
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isHidden = true;

  clearFields() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";
    authService AuthService = authService();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 100.0),
                  child: Text(
                    "Welcome back",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade900),
                  ),
                ),
                Container(
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
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "Enter E-mail",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.indigo,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passwordController,
                obscureText: isHidden,
                decoration: InputDecoration(
                  hintText: "********",
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.indigo,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    icon: Icon(
                      isHidden ? Icons.visibility_off : Icons.visibility,
                      color: Colors.indigo,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: EdgeInsets.only(right: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       // InkWell(
            //       //   onTap: () {
            //       //     Navigator.push(context,
            //       //         MaterialPageRoute(builder: (_) => ForgetPass()));
            //       //   },
            //       //   child: Text(
            //       //     "Forget Password?",
            //       //     style: TextStyle(
            //       //         color: Colors.indigo,
            //       //         fontWeight: FontWeight.bold,
            //       //         fontSize: 18),
            //       //   ),
            //       // )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () async {
                email = _emailController.text;
                password = _passwordController.text;
                print("email: $email");
                print("password: $password");
                dynamic result = await AuthService.loginWithUserNameAndPassword(
                    email, password);
                print("the result of firebase is $result");
                if (result == true) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    text: 'SignIn Successfully!',
                    autoCloseDuration: Duration(seconds: 2),
                    onConfirmBtnTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  );
                } else {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    text: result.toString(),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                    child: Text(
                  "Sign In",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 18, color: Colors.indigo),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Register now!",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class authService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //login

  Future loginWithUserNameAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //registeration

  Future registerUserWithEmailAndPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        //database service
        await databaseService(uid: user.uid).saveUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    await helperFunctions.saveUserLogedInStatus(false);
    await helperFunctions.saveEmail("");
    await helperFunctions.saveUserName("");
    await firebaseAuth.signOut();
  }
}
