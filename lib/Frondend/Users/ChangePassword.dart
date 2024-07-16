import 'package:earthquake_app/Frondend/Users/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _oldController = TextEditingController();
  TextEditingController _newController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();
  bool isHidden = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  clearFields() {
    _oldController.clear();
    _newController.clear();
    _confirmController.clear();
  }

  Future<void> _changePassword() async {
    String oldPassword = _oldController.text;
    String newPassword = _newController.text;
    String confirmPassword = _confirmController.text;

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('New password and confirm password do not match'),
      ));
      return;
    }

    User? user = _auth.currentUser;

    if (user != null) {
      try {
        // Re-authenticate the user
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        );
        await user.reauthenticateWithCredential(credential);

        // Update the password
        await user.updatePassword(newPassword);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password changed successfully'),
        ));

        // Clear the fields after successful password change
        clearFields();

        // Navigate to sign-in screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SignIn()),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $error'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: EdgeInsets.only(left: 80.0),
                  child: Text(
                    "Change Password",
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
                controller: _oldController,
                obscureText: isHidden,
                decoration: InputDecoration(
                  hintText: "Old Password",
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
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _newController,
                obscureText: isHidden,
                decoration: InputDecoration(
                  hintText: "New Password",
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
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _confirmController,
                obscureText: isHidden,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
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
              height: 25,
            ),
            GestureDetector(
              onTap: _changePassword,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                    child: Text(
                  "Change Password",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 35,
                    color: Colors.indigo.shade900,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
