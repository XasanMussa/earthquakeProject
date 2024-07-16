import 'package:earthquake_app/Frondend/Users/ChangePassword.dart';
import 'package:earthquake_app/Frondend/Users/SignIn.dart';
import 'package:flutter/material.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  TextEditingController _emailController = TextEditingController();
  bool isHidden = true;


  clearFields(){
    _emailController.clear();
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
                    borderRadius: BorderRadius.only(
                      // topRight: Radius.circular(10),
                        bottomRight: Radius.circular(200)
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 115.0),
                  child: Text(
                    "Email Verify",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,
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
              height: 105,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
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
                        borderSide:
                        BorderSide(color: Colors.indigo, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: ()  {
                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                    ChangePassword()));
              },
              child: Container(
                width: double.infinity,
                decoration:  BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                margin:  EdgeInsets.symmetric(horizontal: 20),
                padding:  EdgeInsets.symmetric(vertical: 15),
                child:  Center(
                    child: Text(
                      "Verify",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_circle_left_outlined,size: 35,
                    color: Colors.indigo.shade900,)
              ),
            )
          ],
        ),
      ),
    );
  }
}
